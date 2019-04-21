{-# language Strict #-}
{-# language CPP #-}
{-# language DuplicateRecordFields #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}

module Graphics.Vulkan.C.Extensions.VK_NV_corner_sampled_image
  ( VkPhysicalDeviceCornerSampledImageFeaturesNV(..)
  , pattern VK_IMAGE_CREATE_CORNER_SAMPLED_BIT_NV
  , pattern VK_NV_CORNER_SAMPLED_IMAGE_EXTENSION_NAME
  , pattern VK_NV_CORNER_SAMPLED_IMAGE_SPEC_VERSION
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV
  ) where

import Data.String
  ( IsString
  )
import Foreign.Ptr
  ( Ptr
  , plusPtr
  )
import Foreign.Storable
  ( Storable
  , Storable(..)
  )


import Graphics.Vulkan.C.Core10.Core
  ( VkBool32(..)
  , VkStructureType(..)
  , Zero(..)
  )
import Graphics.Vulkan.C.Core10.DeviceInitialization
  ( VkImageCreateFlagBits(..)
  )


-- | VkPhysicalDeviceCornerSampledImageFeaturesNV - Structure describing
-- corner sampled image features that can be supported by an implementation
--
-- = Members
--
-- The members of the 'VkPhysicalDeviceCornerSampledImageFeaturesNV'
-- structure describe the following features:
--
-- = Description
--
-- If the 'VkPhysicalDeviceCornerSampledImageFeaturesNV' structure is
-- included in the @pNext@ chain of
-- 'Graphics.Vulkan.C.Extensions.VK_KHR_get_physical_device_properties2.VkPhysicalDeviceFeatures2KHR',
-- it is filled with values indicating whether each feature is supported.
-- 'VkPhysicalDeviceCornerSampledImageFeaturesNV' /can/ also be used in the
-- @pNext@ chain of 'Graphics.Vulkan.C.Core10.Device.VkDeviceCreateInfo' to
-- enable features.
--
-- Unresolved directive in VkPhysicalDeviceCornerSampledImageFeaturesNV.txt
-- -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceCornerSampledImageFeaturesNV.txt[]
--
-- = See Also
--
-- No cross-references are available
data VkPhysicalDeviceCornerSampledImageFeaturesNV = VkPhysicalDeviceCornerSampledImageFeaturesNV
  { -- No documentation found for Nested "VkPhysicalDeviceCornerSampledImageFeaturesNV" "sType"
  vkSType :: VkStructureType
  , -- No documentation found for Nested "VkPhysicalDeviceCornerSampledImageFeaturesNV" "pNext"
  vkPNext :: Ptr ()
  , -- | @cornerSampledImage@ specifies whether images can be created with a
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@flags@ containing
  -- 'VK_IMAGE_CREATE_CORNER_SAMPLED_BIT_NV'. See
  -- <https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html#resources-images-corner-sampled Corner-Sampled Images>.
  vkCornerSampledImage :: VkBool32
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceCornerSampledImageFeaturesNV where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceCornerSampledImageFeaturesNV <$> peek (ptr `plusPtr` 0)
                                                          <*> peek (ptr `plusPtr` 8)
                                                          <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceCornerSampledImageFeaturesNV))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceCornerSampledImageFeaturesNV))
                *> poke (ptr `plusPtr` 16) (vkCornerSampledImage (poked :: VkPhysicalDeviceCornerSampledImageFeaturesNV))

instance Zero VkPhysicalDeviceCornerSampledImageFeaturesNV where
  zero = VkPhysicalDeviceCornerSampledImageFeaturesNV VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV
                                                      zero
                                                      zero

-- | 'VK_IMAGE_CREATE_CORNER_SAMPLED_BIT_NV' specifies that the image is a
-- <https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html#resources-images-corner-sampled corner-sampled image>.
pattern VK_IMAGE_CREATE_CORNER_SAMPLED_BIT_NV :: VkImageCreateFlagBits
pattern VK_IMAGE_CREATE_CORNER_SAMPLED_BIT_NV = VkImageCreateFlagBits 0x00002000

-- No documentation found for TopLevel "VK_NV_CORNER_SAMPLED_IMAGE_EXTENSION_NAME"
pattern VK_NV_CORNER_SAMPLED_IMAGE_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_NV_CORNER_SAMPLED_IMAGE_EXTENSION_NAME = "VK_NV_corner_sampled_image"

-- No documentation found for TopLevel "VK_NV_CORNER_SAMPLED_IMAGE_SPEC_VERSION"
pattern VK_NV_CORNER_SAMPLED_IMAGE_SPEC_VERSION :: Integral a => a
pattern VK_NV_CORNER_SAMPLED_IMAGE_SPEC_VERSION = 2

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV = VkStructureType 1000050000
