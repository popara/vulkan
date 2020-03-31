{-# language CPP #-}
module Graphics.Vulkan.Core10.Enums.BorderColor  (BorderColor( BORDER_COLOR_FLOAT_TRANSPARENT_BLACK
                                                             , BORDER_COLOR_INT_TRANSPARENT_BLACK
                                                             , BORDER_COLOR_FLOAT_OPAQUE_BLACK
                                                             , BORDER_COLOR_INT_OPAQUE_BLACK
                                                             , BORDER_COLOR_FLOAT_OPAQUE_WHITE
                                                             , BORDER_COLOR_INT_OPAQUE_WHITE
                                                             , ..
                                                             )) where

import GHC.Read (choose)
import GHC.Read (expectP)
import GHC.Read (parens)
import GHC.Show (showParen)
import GHC.Show (showString)
import GHC.Show (showsPrec)
import Text.ParserCombinators.ReadPrec ((+++))
import Text.ParserCombinators.ReadPrec (prec)
import Text.ParserCombinators.ReadPrec (step)
import Foreign.Storable (Storable)
import Data.Int (Int32)
import GHC.Read (Read(readPrec))
import Text.Read.Lex (Lexeme(Ident))
import Graphics.Vulkan.Zero (Zero)
-- | VkBorderColor - Specify border color used for texture lookups
--
-- = Description
--
-- These colors are described in detail in
-- <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#textures-texel-replacement Texel Replacement>.
--
-- = See Also
--
-- 'Graphics.Vulkan.Core10.Sampler.SamplerCreateInfo'
newtype BorderColor = BorderColor Int32
  deriving newtype (Eq, Ord, Storable, Zero)

-- | 'BORDER_COLOR_FLOAT_TRANSPARENT_BLACK' specifies a transparent,
-- floating-point format, black color.
pattern BORDER_COLOR_FLOAT_TRANSPARENT_BLACK = BorderColor 0
-- | 'BORDER_COLOR_INT_TRANSPARENT_BLACK' specifies a transparent, integer
-- format, black color.
pattern BORDER_COLOR_INT_TRANSPARENT_BLACK = BorderColor 1
-- | 'BORDER_COLOR_FLOAT_OPAQUE_BLACK' specifies an opaque, floating-point
-- format, black color.
pattern BORDER_COLOR_FLOAT_OPAQUE_BLACK = BorderColor 2
-- | 'BORDER_COLOR_INT_OPAQUE_BLACK' specifies an opaque, integer format,
-- black color.
pattern BORDER_COLOR_INT_OPAQUE_BLACK = BorderColor 3
-- | 'BORDER_COLOR_FLOAT_OPAQUE_WHITE' specifies an opaque, floating-point
-- format, white color.
pattern BORDER_COLOR_FLOAT_OPAQUE_WHITE = BorderColor 4
-- | 'BORDER_COLOR_INT_OPAQUE_WHITE' specifies an opaque, integer format,
-- white color.
pattern BORDER_COLOR_INT_OPAQUE_WHITE = BorderColor 5
{-# complete BORDER_COLOR_FLOAT_TRANSPARENT_BLACK,
             BORDER_COLOR_INT_TRANSPARENT_BLACK,
             BORDER_COLOR_FLOAT_OPAQUE_BLACK,
             BORDER_COLOR_INT_OPAQUE_BLACK,
             BORDER_COLOR_FLOAT_OPAQUE_WHITE,
             BORDER_COLOR_INT_OPAQUE_WHITE :: BorderColor #-}

instance Show BorderColor where
  showsPrec p = \case
    BORDER_COLOR_FLOAT_TRANSPARENT_BLACK -> showString "BORDER_COLOR_FLOAT_TRANSPARENT_BLACK"
    BORDER_COLOR_INT_TRANSPARENT_BLACK -> showString "BORDER_COLOR_INT_TRANSPARENT_BLACK"
    BORDER_COLOR_FLOAT_OPAQUE_BLACK -> showString "BORDER_COLOR_FLOAT_OPAQUE_BLACK"
    BORDER_COLOR_INT_OPAQUE_BLACK -> showString "BORDER_COLOR_INT_OPAQUE_BLACK"
    BORDER_COLOR_FLOAT_OPAQUE_WHITE -> showString "BORDER_COLOR_FLOAT_OPAQUE_WHITE"
    BORDER_COLOR_INT_OPAQUE_WHITE -> showString "BORDER_COLOR_INT_OPAQUE_WHITE"
    BorderColor x -> showParen (p >= 11) (showString "BorderColor " . showsPrec 11 x)

instance Read BorderColor where
  readPrec = parens (choose [("BORDER_COLOR_FLOAT_TRANSPARENT_BLACK", pure BORDER_COLOR_FLOAT_TRANSPARENT_BLACK)
                            , ("BORDER_COLOR_INT_TRANSPARENT_BLACK", pure BORDER_COLOR_INT_TRANSPARENT_BLACK)
                            , ("BORDER_COLOR_FLOAT_OPAQUE_BLACK", pure BORDER_COLOR_FLOAT_OPAQUE_BLACK)
                            , ("BORDER_COLOR_INT_OPAQUE_BLACK", pure BORDER_COLOR_INT_OPAQUE_BLACK)
                            , ("BORDER_COLOR_FLOAT_OPAQUE_WHITE", pure BORDER_COLOR_FLOAT_OPAQUE_WHITE)
                            , ("BORDER_COLOR_INT_OPAQUE_WHITE", pure BORDER_COLOR_INT_OPAQUE_WHITE)]
                     +++
                     prec 10 (do
                       expectP (Ident "BorderColor")
                       v <- step readPrec
                       pure (BorderColor v)))
