{-# language TemplateHaskellQuotes #-}
module Render.Command
  ( renderCommand
  , constrainStructVariables
  ) where

import           Relude                  hiding ( Reader
                                                , ask
                                                , lift
                                                , runReader
                                                , Type
                                                , Handle
                                                )
import           Data.Text.Prettyprint.Doc
import           Data.Text.Extra                ( upperCaseFirst )
import           Language.Haskell.TH.Syntax     ( nameBase )
import           Data.List.Extra                ( nubOrd )
import           Polysemy
import           Polysemy.Reader
import qualified Data.Text                     as T
import qualified Data.Vector                   as V
import           Data.Vector                    ( Vector )
import           Data.Vector.Extra              ( pattern Empty
                                                , pattern (:<|)
                                                )
import qualified Data.Map                      as Map

import           Control.Monad.Trans.Cont
import           Foreign.C.Types
import           Foreign.Ptr
import qualified GHC.Ptr
import           Control.Exception              ( throwIO )

import           CType                         as C
import           Error
import           Haskell                       as H
import           Marshal
import           Marshal.Marshalable
import           Marshal.Scheme
import           Render.Element
import           Render.Peek
import           Render.Names
import           Render.Stmts
import           Render.Stmts.Poke
import           Render.Stmts.Alloc
import           Render.Scheme
import           Render.SpecInfo
import           Render.Type
import           Spec.Parse

renderCommand
  :: ( HasErr r
     , HasRenderParams r
     , HasSpecInfo r
     , HasStmts r
     , HasRenderedNames r
     )
  => MarshaledCommand
  -> Sem r RenderElement
renderCommand m@MarshaledCommand {..} = contextShow (unCName mcName) $ do
  RenderParams {..} <- ask
  let Command {..} = mcCommand
  genRe ("command " <> unCName mcName) $ do
    ffiTy <- cToHsType
      DoLower
      (Proto cReturnType
             [ (Nothing, pType) | Parameter {..} <- toList cParameters ]
      )
    let dynamicBindType = ConT ''FunPtr :@ ffiTy ~> ffiTy
        dynName         = getDynName mcCommand
    dynamicBindTypeDoc <- renderType dynamicBindType
    importConstructors dynamicBindType
    tellDoc $ vsep
      [ "foreign import ccall"
      , "#if !defined(SAFE_FOREIGN_CALLS)"
      , indent 2 "unsafe"
      , "#endif"
      , indent 2 "\"dynamic\"" <+> pretty dynName
      , indent 2 ("::" <+> dynamicBindTypeDoc)
      ]

    let siblingMap = Map.fromList
          [ (n, SiblingInfo (pretty . unCName $ n) (mpScheme p))
          | p <- V.toList mcParams
          , let n = pName . mpParam $ p
          ]
    let lookupSibling :: CName -> Maybe (SiblingInfo Parameter)
        lookupSibling = (`Map.lookup` siblingMap)


    let commandName = mkFunName mcName
    runReader lookupSibling $ if any (isInOutCount . mpScheme) mcParams
      then marshaledDualPurposeCommandCall commandName m
      else marshaledCommandCall commandName m

paramType
  :: (HasErr r, Member (Reader RenderParams) r)
  => (MarshalScheme Parameter -> Sem r (Maybe H.Type))
  -> MarshaledParam
  -> Sem r (Maybe H.Type)
paramType st MarshaledParam {..} = contextShow (pName mpParam) $ do
  RenderParams {..} <- ask
  let Parameter {..} = mpParam
  n <- st mpScheme
  pure $ namedTy (unName . mkParamName $ pName) <$> n

makeReturnType
  :: (HasErr r, HasRenderParams r, HasSpecInfo r)
  => Bool
  -> Bool
  -> MarshaledCommand
  -> Sem r H.Type
makeReturnType includeInOutCountTypes includeReturnType MarshaledCommand {..} = do
  let pos = \case
        InOutCount _ | not includeInOutCountTypes -> pure Nothing
        s                               -> schemeTypePositive s
  pts <- V.mapMaybe id <$> traverseV (paramType pos) mcParams
  r   <- case mcReturn of
    C.Void                    -> pure V.empty
    _ | not includeReturnType -> pure V.empty
    r                         -> V.singleton <$> cToHsType DoNotPreserve r
  let ts = r <> pts
  pure $ ConT ''IO :@ foldl' (:@) (TupleT (length ts)) ts

constrainStructVariables
  :: (HasErr r, HasRenderParams r, HasRenderElem r, HasRenderedNames r)
  => Type
  -> Sem r Type
constrainStructVariables t = do
  (ns, ps) <- structVariables t
  unless (null ns) $ tellImport (TyConName "PokeChain")
  unless (null ps) $ tellImport (TyConName "PeekChain")
  pure $ ForallT
    []
    (  ((ConT (typeName (TyConName "PokeChain")) :@) . VarT <$> (ns <> ps))
    <> ((ConT (typeName (TyConName "PeekChain")) :@) . VarT <$> ps)
    )
    t

structVariables
  :: (HasErr r, HasRenderedNames r) => Type -> Sem r ([Name], [Name])
  -- ^ negative, positive
structVariables = \case
  ArrowT :@ l :@ r -> do
    (nl, pl) <- structVariables l
    (nr, pr) <- structVariables r
    pure (pl <> nr, nl <> pr)
  InfixT _ i t | i == typeName (TyConName ":::") -> structVariables t
  ConT n :@ VarT v ->
    getRenderedStruct (TyConName (T.pack (nameBase n))) <&> \case
      Just s | not (V.null (sExtendedBy s)) -> ([], [v])
      _ -> ([], [])
  ConT n :@ _ | n == ''Ptr -> pure ([], [])
  f :@ x                  -> liftA2 (<>) (structVariables f) (structVariables x)
  ConT   _                -> pure ([], [])
  TupleT _                -> pure ([], [])
  t ->
    throw $ "Unhandled Type constructor in negativeStructVariables: " <> show t

----------------------------------------------------------------
-- Calling this command
----------------------------------------------------------------

marshaledCommandCall
  :: ( HasErr r
     , HasSpecInfo r
     , HasRenderParams r
     , HasRenderElem r
     , HasStmts r
     , HasSiblingInfo Parameter r
     , HasRenderedNames r
     )
  => HName
  -> MarshaledCommand
  -> Sem r ()
marshaledCommandCall commandName m@MarshaledCommand {..} = do
  RenderParams {..} <- ask

  includeReturnType <- shouldIncludeReturnType m

  tellExport (ETerm commandName)

  let badNames = mempty
  stmtsDoc <- renderStmts badNames $ do
    -- Load the function from the pointer
    funRef    <- getCCall mcCommand

    -- Generate references to the parameters to use later
    paramRefs <- forV mcParams $ \MarshaledParam {..} -> if isElided mpScheme
      then pure Nothing
      else Just <$> do
        ty       <- schemeType mpScheme
        valueRef <-
          stmt ty (Just . unName . mkParamName . pName $ mpParam)
          . pure
          . Pure AlwaysInline
          . ValueDoc
          . pretty
          . mkParamName
          $ pName mpParam
        nameRef (unCName $ pName mpParam) valueRef
        pure valueRef

    -- poke all the parameters
    (pokeRefs, peekRefs) <- V.unzip <$> V.zipWithM getPoke paramRefs mcParams

    -- Bind the result to _ if it can only return success
    let useEmptyBinder =
          not includeReturnType
            && null (cErrorCodes mcCommand)
            && cReturnType mcCommand
            /= Void

    -- Run the command and capture the result
    let name = bool "r" "_" useEmptyBinder
    rTy        <- cToHsType DoLower (cReturnType mcCommand)
    wrappedRef <- stmt (Just rTy) (Just name) $ do
      FunDoc fun <- use funRef
      pokes      <- traverseV use pokeRefs
      -- call the command
      pure . IOAction . ValueDoc $ sep (fun : (unValueDoc <$> toList pokes))
    retRef        <- unwrapIdiomaticType (Just name) wrappedRef

    -- check the result
    checkedResult <- checkResultMaybe mcCommand retRef

    unitStmt $ do
      after checkedResult
      let peeks = catMaybes (toList peekRefs)
      rets <- traverse use $ if includeReturnType then retRef : peeks else peeks
      pure . Pure NeverInline $ tupled @() (unValueDoc <$> rets)

  rhs <- case stmtsDoc of
    IOStmts    d -> pure d
    ContTStmts d -> do
      tellImport 'evalContT
      pure $ "evalContT $" <+> d

  ----------------------------------------------------------------
  -- The type of this command
  ----------------------------------------------------------------
  nts <- V.mapMaybe id <$> traverseV (paramType schemeType) mcParams
  r   <- makeReturnType True includeReturnType m
  let t         = foldr arrowUniqueVars r nts
      paramName = pretty . mkParamName . pName . mpParam
      isArg p = case mpScheme p of
        ElidedLength _ _  -> Nothing
        ElidedUnivalued _ -> Nothing
        ElidedVoid        -> Nothing
        Returned _        -> Nothing
        _                 -> Just p
      paramNames = toList (paramName <$> V.mapMaybe isArg mcParams)
  tDoc <- renderType =<< constrainStructVariables t


  tellDocWithHaddock $ \getDoc -> vsep
    [ getDoc (TopLevel (cName mcCommand))
    , pretty commandName <+> "::" <+> indent 0 tDoc
    , pretty commandName <+> sep paramNames <+> "=" <+> rhs
    ]

----------------------------------------------------------------
-- Checking the result and throwing an exception if something went wrong
----------------------------------------------------------------

-- | Check the result if it has one
checkResultMaybe
  :: (HasErr r, HasRenderParams r, HasRenderElem r, HasSiblingInfo Parameter r)
  => Command
  -> Ref s ValueDoc
  -> Stmt s r (Ref s ValueDoc)
checkResultMaybe Command {..} retRef = do
  RenderParams {..} <- ask
  if null cErrorCodes || cReturnType /= successCodeType
    then pure retRef
    else checkResult retRef

checkResult
  :: (HasErr r, HasRenderParams r, HasRenderElem r, HasSiblingInfo Parameter r)
  => Ref s ValueDoc
  -> Stmt s r (Ref s ValueDoc)
checkResult retRef = do
  check <- unitStmt $ do
    RenderParams {..} <- ask
    ValueDoc ret      <- use retRef
    tellImport 'when
    tellImport 'throwIO
    let pat = mkPatternName firstSuccessCode
    tellImport pat
    tellImportWithAll exceptionTypeName
    pure
      .   IOAction
      .   UnitDoc
      $   "when"
      <+> parens (ret <+> "<" <+> pretty pat)
      <+> parens ("throwIO" <+> parens (pretty exceptionTypeName <+> ret))
  stmt Nothing Nothing $ do
    after check
    r <- use retRef
    pure . Pure AlwaysInline $ r

----------------------------------------------------------------
-- Dual purpose calls
--
-- Sometimes a command returning a vector will allow one to pass in nullPtr for
-- the vector and allocate some memory for the number of elements. This command
-- will intead of filling the vector return the number of potential elements in
-- the allocated count memory. It can then be called again with enough space
-- allocated for the return vector.
--
-- We assume the user will always want to read every element, so we:
--
-- - Poke all unrelated parameters
-- - allocate space for the count
-- - call the function with these parameters and nullPtr for the array
-- - Peek the number of elements
-- - allocate space for these
-- - call the function again with the same parameters and not with space for
--   the return array
-- - Return the array
----------------------------------------------------------------

marshaledDualPurposeCommandCall
  :: ( HasErr r
     , HasSpecInfo r
     , HasRenderParams r
     , HasRenderElem r
     , HasStmts r
     , HasSiblingInfo Parameter r
     , HasRenderedNames r
     )
  => HName
  -> MarshaledCommand
  -> Sem r ()
marshaledDualPurposeCommandCall commandName m@MarshaledCommand {..} = do
  RenderParams {..} <- ask
  tellExport (ETerm commandName)

  --
  -- Find the parameters we want to fiddle with
  --
  countParamIndex <- case V.findIndices (isInOutCount . mpScheme) mcParams of
    Empty -> throw
      "Trying to render a dual purpose command with no InOutCount parameter"
    i :<| Empty -> pure i
    _ ->
      throw
        "Trying to render a dual purpose command with multiple InOutCount parameters"
  let countParam     = mcParams V.! countParamIndex
      countParamName = pName (mpParam countParam)
      isCounted p = pLengths p == V.singleton (NamedLength countParamName)
  vecParamIndices <- case V.findIndices (isCounted . mpParam) mcParams of
    Empty ->
      throw "Trying to render a dual purpose command with no output vector"
    is -> pure is

  --
  -- Get the type of this function
  --
  includeReturnType <- shouldIncludeReturnType m
  let negativeSchemeType = \case
        InOutCount _ -> pure Nothing
        s            -> schemeType s
  nts <- V.mapMaybe id <$> traverseV (paramType negativeSchemeType) mcParams
  returnType <- makeReturnType False includeReturnType m
  let commandType = foldr (~>) returnType nts

  --
  -- Get var names for the LHS
  --
  let paramName = pretty . mkParamName . pName . mpParam
      isArg p = case mpScheme p of
        ElidedLength _ _  -> Nothing
        ElidedUnivalued _ -> Nothing
        ElidedVoid        -> Nothing
        Returned   _      -> Nothing
        InOutCount _      -> Nothing
        _                 -> Just p
      paramNames = toList (paramName <$> V.mapMaybe isArg mcParams)


  let badNames = mempty
  stmtsDoc <- renderStmts badNames $ do

    --
    -- Load the function from the pointer
    --
    funRef <- getCCall mcCommand

    --
    -- Run once to get the length
    --
    (getLengthPokes, getLengthPeeks, countAddr, countPeek) <-
      pokesForGettingCount mcParams countParamIndex vecParamIndices
    ret1 <- runWithPokes False m funRef getLengthPokes

    filledCount <- stmt Nothing Nothing $ do
      after ret1
      ValueDoc v <- use countPeek
      pure . Pure AlwaysInline . ValueDoc $ v
    nameRef (unCName $ pName (mpParam countParam)) filledCount

    (getVectorsPokes, getVectorsPeeks) <- pokesForGettingResults
      mcParams
      getLengthPokes
      getLengthPeeks
      countAddr
      countParamIndex
      vecParamIndices

    ret2          <- runWithPokes includeReturnType m funRef getVectorsPokes

    finalCountRef <- stmt Nothing Nothing $ do
      after ret2
      countScheme <- case mpScheme countParam of
        InOutCount s -> pure s
        _            -> throw "Trying to peek count without inout scheme"
      peekCount <-
        note "Unable to get peek for count"
          =<< peekStmtDirect (mpParam countParam) countAddr countScheme
      Pure InlineOnce <$> use peekCount
    -- TODO: disgusting, this stringly typed stuff
    nameRef (unCName (pName (mpParam countParam)) <> "::2") finalCountRef

    unitStmt $ do
      after ret2
      let peeks = catMaybes (toList getVectorsPeeks)
      rets <- traverse use $ if includeReturnType then ret2 : peeks else peeks
      pure . Pure NeverInline $ tupled @() (unValueDoc <$> rets)

  rhs <- case stmtsDoc of
    IOStmts    d -> pure d
    ContTStmts d -> do
      tellImport 'evalContT
      pure $ "evalContT $" <+> d


  tDoc <- renderType =<< constrainStructVariables commandType
  tellDocWithHaddock $ \getDoc -> vsep
    [ getDoc (TopLevel (cName mcCommand))
    , pretty commandName <+> "::" <+> indent 0 tDoc
    , pretty commandName <+> sep paramNames <+> "=" <+> rhs
    ]

pokesForGettingCount
  :: ( HasErr r
     , HasRenderParams r
     , HasRenderElem r
     , HasSpecInfo r
     , HasStmts r
     , HasSiblingInfo Parameter r
     , HasRenderedNames r
     )
  => Vector MarshaledParam
  -> Int
  -> Vector Int
  -> Stmt
       s
       r
       ( Vector (Ref s ValueDoc)
       , Vector (Maybe (Ref s ValueDoc))
       , Ref s AddrDoc
       , Ref s ValueDoc
       )
pokesForGettingCount params countIndex vecIndices = do
  countOverride <- case params V.!? countIndex of
    Nothing -> throw "Couldn't find count parameter for getting count"
    Just p
      | InOutCount s <- mpScheme p -> do
        (addrRef, peek) <- allocateAndPeek (mpParam p) s
        pure (countIndex, (addrRef, peek))
      | otherwise -> throw "Count doesn't have inout type"
  vecOverrides <- forV vecIndices $ \i -> case params V.!? i of
    Nothing -> throw "Couldn't find vector parameter for getting count"
    Just p
      | Returned _ <- mpScheme p -> pure
        (i, Right p { mpScheme = ElidedUnivalued "nullPtr" })
      | otherwise -> throw $ "Vector doesn't have Returned type, has " <> show
        (mpScheme p)
  let gettingCountParams =
        (Right <$> params)
          V.// (second Left countOverride : V.toList vecOverrides)

  pokes <- forV (V.indexed gettingCountParams) $ \case
    (_, Left (addrRef, peek)) -> do
      poke <- castRef addrRef
      pure (poke, Just peek)
    (i, Right m@MarshaledParam {..}) -> if isElided mpScheme
      then getPoke Nothing m
      else do
        -- Don't name the count ref, because we want to count read after the
        -- second call to have this name.
        ref <- if i == countIndex then paramRefUnnamed m else paramRef m
        getPoke (Just ref) m

  let (countAddr, countPeek) = case countOverride of
        (_, (addr, peek)) -> (addr, peek)

  pure (fst <$> pokes, snd <$> pokes, countAddr, countPeek)

pokesForGettingResults
  :: ( HasErr r
     , HasRenderParams r
     , HasRenderElem r
     , HasSpecInfo r
     , HasStmts r
     , HasSiblingInfo Parameter r
     )
  => Vector MarshaledParam
  -> Vector (Ref s ValueDoc)
  -> Vector (Maybe (Ref s ValueDoc))
  -> Ref s AddrDoc
  -> Int
  -> Vector Int
  -> Stmt
       s
       r
       ( Vector (Ref s ValueDoc)
       , Vector (Maybe (Ref s ValueDoc))
       )
  -- ^ Pokes for this call, peeks for this call
pokesForGettingResults params oldPokes oldPeeks countAddr countIndex vecIndices
  = do
    countOverride                        <- (countIndex, ) <$> castRef countAddr
    (vecPokeOverrides, vecPeekOverrides) <-
      fmap V.unzip . forV vecIndices $ \i -> do
        MarshaledParam {..} <- note "Unable to find vector for returning"
                                    (params V.!? i)
        let lowered        = lowerParamType mpParam
            usingSecondLen = lowered
              { pLengths = case pLengths lowered of
                             NamedLength n :<| t ->
                               -- YUCK
                               NamedLength (CName (unCName n <> "::2")) :<| t
                             t -> t
              }
        scheme <- case mpScheme of
          Returned s -> pure s
          _          -> throw "Vector without a return scheme"
        addr  <- allocate lowered scheme
        addr' <- castRef addr
        peek  <-
          note "Unable to get peek for returned value"
            =<< peekStmtDirect usingSecondLen addr scheme
        pure ((i, addr'), (i, Just peek))
    let newPokes = oldPokes V.// (countOverride : toList vecPokeOverrides)
        newPeeks =
          oldPeeks V.// ((countIndex, Nothing) : toList vecPeekOverrides)
    pure (newPokes, newPeeks)


runWithPokes
  :: (HasErr r, HasRenderParams r, HasRenderElem r, HasSiblingInfo Parameter r)
  => Bool
  -> MarshaledCommand
  -> Ref s FunDoc
  -> Vector (Ref s ValueDoc)
  -> Stmt s r (Ref s ValueDoc)
runWithPokes includeReturnType MarshaledCommand {..} funRef pokes = do
  -- Bind the result to _ if it can only return success
  let useEmptyBinder =
        not includeReturnType
          && null (cErrorCodes mcCommand)
          && cReturnType mcCommand
          /= Void
  retRef <- stmt Nothing (Just (bool "r" "_" useEmptyBinder)) $ do
    FunDoc fun <- use funRef
    pokes      <- traverseV use pokes
    -- call the command
    pure . IOAction . ValueDoc $ sep (fun : (unValueDoc <$> toList pokes))

  checkResultMaybe mcCommand retRef

----------------------------------------------------------------
--
----------------------------------------------------------------

paramRef
  :: (HasRenderParams r, HasRenderElem r, HasErr r, HasSpecInfo r)
  => MarshaledParam
  -> Stmt s r (Ref s ValueDoc)
paramRef mp@MarshaledParam {..} = do
  valueRef <- paramRefUnnamed mp
  nameRef (unCName $ pName mpParam) valueRef
  pure valueRef

paramRefUnnamed
  :: (HasRenderParams r, HasRenderElem r, HasErr r, HasSpecInfo r)
  => MarshaledParam
  -> Stmt s r (Ref s ValueDoc)
paramRefUnnamed MarshaledParam {..} = do
  RenderParams {..} <- ask
  ty                <- schemeType mpScheme
  stmt ty (Just . unName . mkParamName . pName $ mpParam)
    . pure
    . Pure AlwaysInline
    . ValueDoc
    . pretty
    . mkParamName
    $ pName mpParam

shouldIncludeReturnType :: HasRenderParams r => MarshaledCommand -> Sem r Bool
shouldIncludeReturnType MarshaledCommand {..} = do
  RenderParams {..} <- ask
  pure
    $  mcReturn
    /= C.Void
    && (mcReturn == successCodeType --> any isSuccessCodeReturned
                                            (cSuccessCodes mcCommand)
       )

castRef
  :: forall a b r s
   . HasErr r
  => (Typeable b, Coercible a b, Coercible b (Doc ()))
  => Ref s a
  -> Stmt s r (Ref s b)
castRef ref = stmt Nothing Nothing $ do
  r <- use ref
  pure . Pure AlwaysInline . coerce $ r

----------------------------------------------------------------
-- Getting C call
----------------------------------------------------------------

getCCall
  :: ( HasErr r
     , HasRenderParams r
     , HasSpecInfo r
     , HasRenderParams r
     , HasRenderElem r
     )
  => Command
  -> Stmt s r (Ref s FunDoc)
getCCall c = do
  RenderParams {..} <- ask
  let -- What to do in the case that this command isn't dispatched from a handle
      noHandle = stmt Nothing (Just (unCName (cName c) <> "'")) $ do
        -- TODO: Change this function pointer to a "global variable" with ioref and
        -- unsafePerformIO
        let getInstanceProcAddr' = mkFunName "vkGetInstanceProcAddr'" -- TODO: Remove vulkan specific stuff here!
        tellImport getInstanceProcAddr' -- TODO: Remove vulkan specific stuff here!
        tellImport 'nullPtr
        tellImport 'castFunPtr
        tellImportWith ''GHC.Ptr.Ptr 'GHC.Ptr.Ptr
        let dynName = getDynName c
        fTyDoc <- renderTypeHighPrec =<< cToHsTypeWithHoles
          DoLower
          (C.Proto
            (cReturnType c)
            [ (Just (unCName pName), pType)
            | Parameter {..} <- V.toList (cParameters c)
            ]
          )
        pure
          .   IOAction
          .   FunDoc
          $   pretty dynName
          <+> ". castFunPtr @_ @"
          <>  fTyDoc
          <+> "<$>"
          <+> pretty getInstanceProcAddr'
          <+> "nullPtr"
          <+> parens ("Ptr" <+> dquotes (pretty (unCName (cName c))) <> "#")

      -- What do do if we need to extract the command pointer from a parameter
      cmdsFun ptrRecTyName getCmdsFun paramName paramType = do
        cmdsRef <- stmt Nothing (Just "cmds") $ do
          paramTDoc <- renderType =<< cToHsType DoNotPreserve paramType
          getCmds   <- getCmdsFun
          pure . Pure InlineOnce . CmdsDoc $ getCmds <+> parens
            (pretty paramName <+> "::" <+> paramTDoc)
        nameRef "cmds" cmdsRef
        stmt Nothing (Just (unCName (cName c) <> "'")) $ do
          let dynName    = getDynName c
              memberName = mkFuncPointerMemberName (cName c)
          tellImportWith ptrRecTyName memberName
          CmdsDoc cmds <- use cmdsRef
          pure . Pure NeverInline . FunDoc $ pretty dynName <+> parens
            (pretty memberName <+> cmds)

  commandHandle c >>= \case
    Nothing                            -> noHandle
    Just (Parameter {..}, Handle {..}) -> do
      let
        withImport member = do
          tellImportWithAll (mkTyName hName)
          pure $ pretty (member :: Text)
        instanceHandle = cmdsFun (TyConName "InstanceCmds")
                                 (withImport "instanceCmds")
                                 paramName
                                 pType
        deviceHandle = cmdsFun (TyConName "DeviceCmds")
                               (withImport "deviceCmds")
                               paramName
                               pType
        paramName = mkParamName pName
      case hLevel of
        NoHandleLevel -> noHandle
        Device        -> deviceHandle
        Instance      -> instanceHandle

-- | The handle of a command is the (dispatchable handle) first parameter.
commandHandle :: HasSpecInfo r => Command -> Sem r (Maybe (Parameter, Handle))
commandHandle Command {..} = case cParameters V.!? 0 of
  Just p@Parameter {..} | TypeName t <- pType -> fmap (p, ) <$> getHandle t
  _ -> pure Nothing

----------------------------------------------------------------
-- Poking values
----------------------------------------------------------------

-- | This also takes care of allocating for returned values
getPoke
  :: ( HasErr r
     , HasRenderElem r
     , HasRenderParams r
     , HasSpecInfo r
     , HasStmts r
     , HasSiblingInfo Parameter r
     , HasRenderedNames r
     )
  => Maybe (Ref s ValueDoc)
  -- ^ Might be nothing if this is elided
  -> MarshaledParam
  -> Stmt s r (Ref s ValueDoc, Maybe (Ref s ValueDoc))
  -- ^ (poke, peek if it's a returned value)
getPoke valueRef MarshaledParam {..} = do
  RenderParams {..} <- ask
  case mpScheme of
    Returned s -> do
      (addrRef, peek) <- allocateAndPeek (lowerParamType mpParam) s
      -- TODO: implement ref casting
      addrRef'        <- stmt Nothing Nothing $ do
        AddrDoc addr <- use addrRef
        pure . Pure AlwaysInline . ValueDoc $ addr
      pure (addrRef', Just peek)
    _ -> (, Nothing) <$> case valueRef of
      Nothing -> do
        -- Give the refs names now as they didn't get one earlier
        r <- getPokeDirectElided (lowerParamType mpParam) mpScheme
        nameRef (unCName $ pName mpParam) r
        pure r
      Just valueRef -> getPokeDirect (lowerParamType mpParam) mpScheme valueRef

-- | Parameters of type foo[x] are passed as pointers
lowerParamType :: Parameter -> Parameter
lowerParamType p@Parameter {..} = case pType of
  Array q _ elem -> p { pType = Ptr q elem }
  _              -> p

----------------------------------------------------------------
-- ImportConstructors
----------------------------------------------------------------

-- | Foreign imports require constructors in scope for newtypes
importConstructors
  :: forall r
   . (HasSpecInfo r, HasRenderElem r, HasRenderParams r, HasRenderedNames r)
  => Type
  -> Sem r ()
importConstructors t = do
  RenderParams {..} <- ask
  let names = nubOrd $ allTypeNames t
      isNewtype' :: Name -> Sem r Bool
      isNewtype' n = pure (n `elem` builtinNewtypes)
        <||> isNewtype (TyConName . T.pack . nameBase $ n)
  for_ names $ \n -> whenM (isNewtype' n) $ tellImportWithAll n

builtinNewtypes :: [Name]
builtinNewtypes =
  [ ''CChar
  , ''CSChar
  , ''CUChar
  , ''CShort
  , ''CUShort
  , ''CInt
  , ''CUInt
  , ''CLong
  , ''CULong
  , ''CPtrdiff
  , ''CSize
  , ''CWchar
  , ''CSigAtomic
  , ''CLLong
  , ''CULLong
  , ''CBool
  , ''CIntPtr
  , ''CUIntPtr
  , ''CIntMax
  , ''CUIntMax
  , ''CClock
  , ''CTime
  , ''CUSeconds
  , ''CSUSeconds
  , ''CFloat
  , ''CDouble
  ]

----------------------------------------------------------------
-- Utils
----------------------------------------------------------------

getDynName :: Command -> Text
getDynName = ("mk" <>) . upperCaseFirst . unCName . cName

infixr 2 -->
(-->) :: Bool -> Bool -> Bool
a --> b = not a || b

(<||>) :: Applicative f => f Bool -> f Bool -> f Bool
(<||>) = liftA2 (||)