module Marshal.Struct
  ( marshalStruct
  , MarshaledStruct(..)
  , MarshaledStructMember(..)
  ) where

import           Relude                  hiding ( Reader
                                                , ask
                                                )
import           Polysemy
import           Polysemy.NonDet
import           Polysemy.Reader
import           Polysemy.Fail
import qualified Data.Vector                   as V

import           Spec.Parse
import           Error
import           Marshal.Scheme
import           Render.SpecInfo

data MarshaledStruct t = MarshaledStruct
  { msName    :: CName
  , msStruct  :: StructOrUnion t 'WithSize 'WithChildren
  , msMembers :: V.Vector MarshaledStructMember
  }

data MarshaledStructMember =
  MarshaledStructMember
    { msmStructMember :: StructMember
    , msmScheme :: MarshalScheme StructMember
    }

marshalStruct
  :: (MemberWithError (Reader MarshalParams) r, HasErr r, HasSpecInfo r)
  => StructOrUnion t 'WithSize 'WithChildren
  -> Sem r (MarshaledStruct t)
marshalStruct s@Struct {..} = contextShow sName $ do
  let msName = sName
      msStruct = s
  msMembers <- forV sMembers $ \sm -> contextShow (smName sm) $ do
    scheme <- structMemberScheme s sm
    pure $ MarshaledStructMember sm scheme
  pure MarshaledStruct { .. }

structMemberScheme
  :: (MemberWithError (Reader MarshalParams) r, HasErr r, HasSpecInfo r)
  => StructOrUnion t 'WithSize 'WithChildren
  -> StructMember
  -> Sem r (MarshalScheme StructMember)
structMemberScheme Struct {..} member = do
  MarshalParams {..} <- ask
  let
    schemes =
      [ maybe empty pure . getBespokeScheme sName
      , -- These two are for value constrained params:
        univaluedScheme
      , lengthScheme sMembers
        -- Pointers to Void have some special handling
      , voidPointerScheme
        -- Pointers to return values in, unmarshaled at the moment
      , returnPointerInStructScheme
        -- Optional and non optional arrays
      , arrayScheme WrapExtensibleStructs DoNotWrapDispatchableHandles
      , fixedArrayScheme WrapExtensibleStructs DoNotWrapDispatchableHandles
        -- Optional things:
      , optionalDefaultScheme WrapExtensibleStructs DoNotWrapDispatchableHandles
      , optionalScheme WrapExtensibleStructs DoNotWrapDispatchableHandles
        -- Structs which can be extended, so need to be wrapped in a GADT
      , extensibleStruct
        -- Structs don't have wrapped handles because it's annoying to pass
        -- the command record into the peek functions
      , rawDispatchableHandles
        -- Everything left over is treated as a boring scalar parameter
      , scalarScheme
      ]
  m <- runNonDet . failToNonDet . asum . fmap ($ member) $ schemes
  case m of
    Just x  -> pure x
    Nothing -> throw
      ("Not handled by any marshaling scheme. Type: " <> show (smType member))
