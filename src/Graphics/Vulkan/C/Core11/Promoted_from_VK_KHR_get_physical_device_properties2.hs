{-# language Strict #-}
{-# language CPP #-}
{-# language DuplicateRecordFields #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language PatternSynonyms #-}

module Graphics.Vulkan.C.Core11.Promoted_from_VK_KHR_get_physical_device_properties2
  ( VkFormatProperties2(..)
  , VkImageFormatProperties2(..)
  , VkPhysicalDeviceFeatures2(..)
  , VkPhysicalDeviceImageFormatInfo2(..)
  , VkPhysicalDeviceMemoryProperties2(..)
  , VkPhysicalDeviceProperties2(..)
  , VkPhysicalDeviceSparseImageFormatInfo2(..)
  , VkQueueFamilyProperties2(..)
  , VkSparseImageFormatProperties2(..)
  , FN_vkGetPhysicalDeviceFeatures2
  , PFN_vkGetPhysicalDeviceFeatures2
  , vkGetPhysicalDeviceFeatures2
  , FN_vkGetPhysicalDeviceFormatProperties2
  , PFN_vkGetPhysicalDeviceFormatProperties2
  , vkGetPhysicalDeviceFormatProperties2
  , FN_vkGetPhysicalDeviceImageFormatProperties2
  , PFN_vkGetPhysicalDeviceImageFormatProperties2
  , vkGetPhysicalDeviceImageFormatProperties2
  , FN_vkGetPhysicalDeviceMemoryProperties2
  , PFN_vkGetPhysicalDeviceMemoryProperties2
  , vkGetPhysicalDeviceMemoryProperties2
  , FN_vkGetPhysicalDeviceProperties2
  , PFN_vkGetPhysicalDeviceProperties2
  , vkGetPhysicalDeviceProperties2
  , FN_vkGetPhysicalDeviceQueueFamilyProperties2
  , PFN_vkGetPhysicalDeviceQueueFamilyProperties2
  , vkGetPhysicalDeviceQueueFamilyProperties2
  , FN_vkGetPhysicalDeviceSparseImageFormatProperties2
  , PFN_vkGetPhysicalDeviceSparseImageFormatProperties2
  , vkGetPhysicalDeviceSparseImageFormatProperties2
  , pattern VK_STRUCTURE_TYPE_FORMAT_PROPERTIES_2
  , pattern VK_STRUCTURE_TYPE_IMAGE_FORMAT_PROPERTIES_2
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PROPERTIES_2
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2
  , pattern VK_STRUCTURE_TYPE_QUEUE_FAMILY_PROPERTIES_2
  , pattern VK_STRUCTURE_TYPE_SPARSE_IMAGE_FORMAT_PROPERTIES_2
  ) where

import Data.Word
  ( Word32
  )
import Foreign.Ptr
  ( FunPtr
  , Ptr
  , plusPtr
  )
import Foreign.Storable
  ( Storable
  , Storable(..)
  )


import Graphics.Vulkan.C.Core10.Core
  ( VkFormat(..)
  , VkResult(..)
  , VkStructureType(..)
  , Zero(..)
  )
import Graphics.Vulkan.C.Core10.DeviceInitialization
  ( VkFormatProperties(..)
  , VkImageFormatProperties(..)
  , VkImageTiling(..)
  , VkImageType(..)
  , VkPhysicalDeviceFeatures(..)
  , VkPhysicalDeviceMemoryProperties(..)
  , VkPhysicalDeviceProperties(..)
  , VkQueueFamilyProperties(..)
  , VkSampleCountFlagBits(..)
  , VkImageCreateFlags
  , VkImageUsageFlags
  , VkPhysicalDevice
  )
import Graphics.Vulkan.C.Core10.SparseResourceMemoryManagement
  ( VkSparseImageFormatProperties(..)
  )
import Graphics.Vulkan.C.Dynamic
  ( InstanceCmds(..)
  )
import Graphics.Vulkan.NamedType
  ( (:::)
  )


-- | VkFormatProperties2 - Structure specifying image format properties
--
-- = Description
--
-- Unresolved directive in VkFormatProperties2.txt -
-- include::{generated}\/validity\/structs\/VkFormatProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkFormatProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceFormatProperties2'
data VkFormatProperties2 = VkFormatProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @formatProperties@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkFormatProperties'
  -- describing features supported by the requested format.
  vkFormatProperties :: VkFormatProperties
  }
  deriving (Eq, Show)

instance Storable VkFormatProperties2 where
  sizeOf ~_ = 32
  alignment ~_ = 8
  peek ptr = VkFormatProperties2 <$> peek (ptr `plusPtr` 0)
                                 <*> peek (ptr `plusPtr` 8)
                                 <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkFormatProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkFormatProperties2))
                *> poke (ptr `plusPtr` 16) (vkFormatProperties (poked :: VkFormatProperties2))

instance Zero VkFormatProperties2 where
  zero = VkFormatProperties2 VK_STRUCTURE_TYPE_FORMAT_PROPERTIES_2
                             zero
                             zero

-- | VkImageFormatProperties2 - Structure specifying an image format
-- properties
--
-- = Description
--
-- If the combination of parameters to
-- 'vkGetPhysicalDeviceImageFormatProperties2' is not supported by the
-- implementation for use in
-- 'Graphics.Vulkan.C.Core10.Image.vkCreateImage', then all members of
-- @imageFormatProperties@ will be filled with zero.
--
-- __Note__
--
-- Filling @imageFormatProperties@ with zero for unsupported formats is an
-- exception to the usual rule that output structures have undefined
-- contents on error. This exception was unintentional, but is preserved
-- for backwards compatibility. This exeption only applies to
-- @imageFormatProperties@, not @sType@, @pNext@, or any structures chained
-- from @pNext@.
--
-- Unresolved directive in VkImageFormatProperties2.txt -
-- include::{generated}\/validity\/structs\/VkImageFormatProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageFormatProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceImageFormatProperties2'
data VkImageFormatProperties2 = VkImageFormatProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure. The
  -- @pNext@ chain of 'VkImageFormatProperties2' is used to allow the
  -- specification of additional capabilities to be returned from
  -- 'vkGetPhysicalDeviceImageFormatProperties2'.
  vkPNext :: Ptr ()
  , -- | @imageFormatProperties@ is an instance of a
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageFormatProperties'
  -- structure in which capabilities are returned.
  vkImageFormatProperties :: VkImageFormatProperties
  }
  deriving (Eq, Show)

instance Storable VkImageFormatProperties2 where
  sizeOf ~_ = 48
  alignment ~_ = 8
  peek ptr = VkImageFormatProperties2 <$> peek (ptr `plusPtr` 0)
                                      <*> peek (ptr `plusPtr` 8)
                                      <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkImageFormatProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkImageFormatProperties2))
                *> poke (ptr `plusPtr` 16) (vkImageFormatProperties (poked :: VkImageFormatProperties2))

instance Zero VkImageFormatProperties2 where
  zero = VkImageFormatProperties2 VK_STRUCTURE_TYPE_IMAGE_FORMAT_PROPERTIES_2
                                  zero
                                  zero

-- | VkPhysicalDeviceFeatures2 - Structure describing the fine-grained
-- features that can be supported by an implementation
--
-- = Members
--
-- The 'VkPhysicalDeviceFeatures2' structure is defined as:
--
-- = Description
--
-- The @pNext@ chain of this structure is used to extend the structure with
-- features defined by extensions. This structure /can/ be used in
-- 'vkGetPhysicalDeviceFeatures2' or /can/ be in the @pNext@ chain of a
-- 'Graphics.Vulkan.C.Core10.Device.VkDeviceCreateInfo' structure, in which
-- case it controls which features are enabled in the device in lieu of
-- @pEnabledFeatures@.
--
-- Unresolved directive in VkPhysicalDeviceFeatures2.txt -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceFeatures2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceFeatures',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceFeatures2'
data VkPhysicalDeviceFeatures2 = VkPhysicalDeviceFeatures2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @features@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceFeatures'
  -- describing the fine-grained features of the Vulkan 1.0 API.
  vkFeatures :: VkPhysicalDeviceFeatures
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceFeatures2 where
  sizeOf ~_ = 240
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceFeatures2 <$> peek (ptr `plusPtr` 0)
                                       <*> peek (ptr `plusPtr` 8)
                                       <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceFeatures2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceFeatures2))
                *> poke (ptr `plusPtr` 16) (vkFeatures (poked :: VkPhysicalDeviceFeatures2))

instance Zero VkPhysicalDeviceFeatures2 where
  zero = VkPhysicalDeviceFeatures2 VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2
                                   zero
                                   zero

-- | VkPhysicalDeviceImageFormatInfo2 - Structure specifying image creation
-- parameters
--
-- = Description
--
-- The members of 'VkPhysicalDeviceImageFormatInfo2' correspond to the
-- arguments to
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceImageFormatProperties',
-- with @sType@ and @pNext@ added for extensibility.
--
-- == Valid Usage
--
-- -   @tiling@ /must/ be
--     'Graphics.Vulkan.C.Extensions.VK_EXT_image_drm_format_modifier.VK_IMAGE_TILING_DRM_FORMAT_MODIFIER_EXT'
--     if and only if the @pNext@ chain contains
--     'Graphics.Vulkan.C.Extensions.VK_EXT_image_drm_format_modifier.VkPhysicalDeviceImageDrmFormatModifierInfoEXT'.
--
-- -   If @tiling@ is
--     'Graphics.Vulkan.C.Extensions.VK_EXT_image_drm_format_modifier.VK_IMAGE_TILING_DRM_FORMAT_MODIFIER_EXT'
--     and @flags@ contains
--     'Graphics.Vulkan.C.Core10.DeviceInitialization.VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT',
--     then the @pNext@ chain /must/ contain
--     'Graphics.Vulkan.C.Extensions.VK_KHR_image_format_list.VkImageFormatListCreateInfoKHR'
--     with non-zero @viewFormatCount@.
--
-- Unresolved directive in VkPhysicalDeviceImageFormatInfo2.txt -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceImageFormatInfo2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.Core.VkFormat',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageCreateFlags',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageTiling',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageType',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageUsageFlags',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceImageFormatProperties2'
data VkPhysicalDeviceImageFormatInfo2 = VkPhysicalDeviceImageFormatInfo2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure. The
  -- @pNext@ chain of 'VkPhysicalDeviceImageFormatInfo2' is used to provide
  -- additional image parameters to
  -- 'vkGetPhysicalDeviceImageFormatProperties2'.
  vkPNext :: Ptr ()
  , -- | @format@ is a 'Graphics.Vulkan.C.Core10.Core.VkFormat' value indicating
  -- the image format, corresponding to
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@format@.
  vkFormat :: VkFormat
  , -- | @type@ is a 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageType'
  -- value indicating the image type, corresponding to
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@imageType@.
  vkType :: VkImageType
  , -- | @tiling@ is a
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageTiling' value
  -- indicating the image tiling, corresponding to
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@tiling@.
  vkTiling :: VkImageTiling
  , -- | @usage@ is a bitmask of
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageUsageFlagBits'
  -- indicating the intended usage of the image, corresponding to
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@usage@.
  vkUsage :: VkImageUsageFlags
  , -- | @flags@ is a bitmask of
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageCreateFlagBits'
  -- indicating additional parameters of the image, corresponding to
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@flags@.
  vkFlags :: VkImageCreateFlags
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceImageFormatInfo2 where
  sizeOf ~_ = 40
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceImageFormatInfo2 <$> peek (ptr `plusPtr` 0)
                                              <*> peek (ptr `plusPtr` 8)
                                              <*> peek (ptr `plusPtr` 16)
                                              <*> peek (ptr `plusPtr` 20)
                                              <*> peek (ptr `plusPtr` 24)
                                              <*> peek (ptr `plusPtr` 28)
                                              <*> peek (ptr `plusPtr` 32)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 16) (vkFormat (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 20) (vkType (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 24) (vkTiling (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 28) (vkUsage (poked :: VkPhysicalDeviceImageFormatInfo2))
                *> poke (ptr `plusPtr` 32) (vkFlags (poked :: VkPhysicalDeviceImageFormatInfo2))

instance Zero VkPhysicalDeviceImageFormatInfo2 where
  zero = VkPhysicalDeviceImageFormatInfo2 VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2
                                          zero
                                          zero
                                          zero
                                          zero
                                          zero
                                          zero

-- | VkPhysicalDeviceMemoryProperties2 - Structure specifying physical device
-- memory properties
--
-- = Description
--
-- Unresolved directive in VkPhysicalDeviceMemoryProperties2.txt -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceMemoryProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceMemoryProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceMemoryProperties2'
data VkPhysicalDeviceMemoryProperties2 = VkPhysicalDeviceMemoryProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @memoryProperties@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceMemoryProperties'
  -- which is populated with the same values as in
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceMemoryProperties'.
  vkMemoryProperties :: VkPhysicalDeviceMemoryProperties
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceMemoryProperties2 where
  sizeOf ~_ = 536
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceMemoryProperties2 <$> peek (ptr `plusPtr` 0)
                                               <*> peek (ptr `plusPtr` 8)
                                               <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceMemoryProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceMemoryProperties2))
                *> poke (ptr `plusPtr` 16) (vkMemoryProperties (poked :: VkPhysicalDeviceMemoryProperties2))

instance Zero VkPhysicalDeviceMemoryProperties2 where
  zero = VkPhysicalDeviceMemoryProperties2 VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PROPERTIES_2
                                           zero
                                           zero

-- | VkPhysicalDeviceProperties2 - Structure specifying physical device
-- properties
--
-- = Description
--
-- The @pNext@ chain of this structure is used to extend the structure with
-- properties defined by extensions.
--
-- Unresolved directive in VkPhysicalDeviceProperties2.txt -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceProperties2'
data VkPhysicalDeviceProperties2 = VkPhysicalDeviceProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @properties@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDeviceProperties'
  -- describing the properties of the physical device. This structure is
  -- written with the same values as if it were written by
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceProperties'.
  vkProperties :: VkPhysicalDeviceProperties
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceProperties2 where
  sizeOf ~_ = 840
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceProperties2 <$> peek (ptr `plusPtr` 0)
                                         <*> peek (ptr `plusPtr` 8)
                                         <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceProperties2))
                *> poke (ptr `plusPtr` 16) (vkProperties (poked :: VkPhysicalDeviceProperties2))

instance Zero VkPhysicalDeviceProperties2 where
  zero = VkPhysicalDeviceProperties2 VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2
                                     zero
                                     zero

-- | VkPhysicalDeviceSparseImageFormatInfo2 - Structure specifying sparse
-- image format inputs
--
-- == Valid Usage
--
-- Unresolved directive in VkPhysicalDeviceSparseImageFormatInfo2.txt -
-- include::{generated}\/validity\/structs\/VkPhysicalDeviceSparseImageFormatInfo2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.Core.VkFormat',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageTiling',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageType',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageUsageFlags',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkSampleCountFlagBits',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceSparseImageFormatProperties2'
data VkPhysicalDeviceSparseImageFormatInfo2 = VkPhysicalDeviceSparseImageFormatInfo2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @format@ is the image format.
  vkFormat :: VkFormat
  , -- | @type@ is the dimensionality of image.
  vkType :: VkImageType
  , -- | @samples@ /must/ be a bit value that is set in
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkImageFormatProperties'::@sampleCounts@
  -- returned by
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceImageFormatProperties'
  -- with @format@, @type@, @tiling@, and @usage@ equal to those in this
  -- command and @flags@ equal to the value that is set in
  -- 'Graphics.Vulkan.C.Core10.Image.VkImageCreateInfo'::@flags@ when the
  -- image is created
  vkSamples :: VkSampleCountFlagBits
  , -- | @usage@ is a bitmask describing the intended usage of the image.
  vkUsage :: VkImageUsageFlags
  , -- | @tiling@ is the tiling arrangement of the texel blocks in memory.
  vkTiling :: VkImageTiling
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceSparseImageFormatInfo2 where
  sizeOf ~_ = 40
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceSparseImageFormatInfo2 <$> peek (ptr `plusPtr` 0)
                                                    <*> peek (ptr `plusPtr` 8)
                                                    <*> peek (ptr `plusPtr` 16)
                                                    <*> peek (ptr `plusPtr` 20)
                                                    <*> peek (ptr `plusPtr` 24)
                                                    <*> peek (ptr `plusPtr` 28)
                                                    <*> peek (ptr `plusPtr` 32)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 16) (vkFormat (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 20) (vkType (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 24) (vkSamples (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 28) (vkUsage (poked :: VkPhysicalDeviceSparseImageFormatInfo2))
                *> poke (ptr `plusPtr` 32) (vkTiling (poked :: VkPhysicalDeviceSparseImageFormatInfo2))

instance Zero VkPhysicalDeviceSparseImageFormatInfo2 where
  zero = VkPhysicalDeviceSparseImageFormatInfo2 VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2
                                                zero
                                                zero
                                                zero
                                                zero
                                                zero
                                                zero

-- | VkQueueFamilyProperties2 - Structure providing information about a queue
-- family
--
-- = Description
--
-- Unresolved directive in VkQueueFamilyProperties2.txt -
-- include::{generated}\/validity\/structs\/VkQueueFamilyProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkQueueFamilyProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceQueueFamilyProperties2'
data VkQueueFamilyProperties2 = VkQueueFamilyProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @queueFamilyProperties@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkQueueFamilyProperties'
  -- which is populated with the same values as in
  -- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceQueueFamilyProperties'.
  vkQueueFamilyProperties :: VkQueueFamilyProperties
  }
  deriving (Eq, Show)

instance Storable VkQueueFamilyProperties2 where
  sizeOf ~_ = 40
  alignment ~_ = 8
  peek ptr = VkQueueFamilyProperties2 <$> peek (ptr `plusPtr` 0)
                                      <*> peek (ptr `plusPtr` 8)
                                      <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkQueueFamilyProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkQueueFamilyProperties2))
                *> poke (ptr `plusPtr` 16) (vkQueueFamilyProperties (poked :: VkQueueFamilyProperties2))

instance Zero VkQueueFamilyProperties2 where
  zero = VkQueueFamilyProperties2 VK_STRUCTURE_TYPE_QUEUE_FAMILY_PROPERTIES_2
                                  zero
                                  zero

-- | VkSparseImageFormatProperties2 - Structure specifying sparse image
-- format properties
--
-- = Description
--
-- Unresolved directive in VkSparseImageFormatProperties2.txt -
-- include::{generated}\/validity\/structs\/VkSparseImageFormatProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.SparseResourceMemoryManagement.VkSparseImageFormatProperties',
-- 'Graphics.Vulkan.C.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceSparseImageFormatProperties2'
data VkSparseImageFormatProperties2 = VkSparseImageFormatProperties2
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @properties@ is a structure of type
  -- 'Graphics.Vulkan.C.Core10.SparseResourceMemoryManagement.VkSparseImageFormatProperties'
  -- which is populated with the same values as in
  -- 'Graphics.Vulkan.C.Core10.SparseResourceMemoryManagement.vkGetPhysicalDeviceSparseImageFormatProperties'.
  vkProperties :: VkSparseImageFormatProperties
  }
  deriving (Eq, Show)

instance Storable VkSparseImageFormatProperties2 where
  sizeOf ~_ = 40
  alignment ~_ = 8
  peek ptr = VkSparseImageFormatProperties2 <$> peek (ptr `plusPtr` 0)
                                            <*> peek (ptr `plusPtr` 8)
                                            <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkSparseImageFormatProperties2))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkSparseImageFormatProperties2))
                *> poke (ptr `plusPtr` 16) (vkProperties (poked :: VkSparseImageFormatProperties2))

instance Zero VkSparseImageFormatProperties2 where
  zero = VkSparseImageFormatProperties2 VK_STRUCTURE_TYPE_SPARSE_IMAGE_FORMAT_PROPERTIES_2
                                        zero
                                        zero

-- | vkGetPhysicalDeviceFeatures2 - Reports capabilities of a physical device
--
-- = Parameters
--
-- -   @physicalDevice@ is the physical device from which to query the
--     supported features.
--
-- -   @pFeatures@ is a pointer to a 'VkPhysicalDeviceFeatures2' structure
--     in which the physical device features are returned.
--
-- = Description
--
-- Each structure in @pFeatures@ and its @pNext@ chain contain members
-- corresponding to fine-grained features. 'vkGetPhysicalDeviceFeatures2'
-- writes each member to a boolean value indicating whether that feature is
-- supported.
--
-- Unresolved directive in vkGetPhysicalDeviceFeatures2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceFeatures2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceFeatures2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceFeatures2" vkGetPhysicalDeviceFeatures2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pFeatures" ::: Ptr VkPhysicalDeviceFeatures2) -> IO ()
#else
vkGetPhysicalDeviceFeatures2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pFeatures" ::: Ptr VkPhysicalDeviceFeatures2) -> IO ()
vkGetPhysicalDeviceFeatures2 deviceCmds = mkVkGetPhysicalDeviceFeatures2 (pVkGetPhysicalDeviceFeatures2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceFeatures2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pFeatures" ::: Ptr VkPhysicalDeviceFeatures2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pFeatures" ::: Ptr VkPhysicalDeviceFeatures2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceFeatures2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pFeatures" ::: Ptr VkPhysicalDeviceFeatures2) -> IO ()
type PFN_vkGetPhysicalDeviceFeatures2 = FunPtr FN_vkGetPhysicalDeviceFeatures2

-- | vkGetPhysicalDeviceFormatProperties2 - Lists physical device’s format
-- capabilities
--
-- = Parameters
--
-- -   @physicalDevice@ is the physical device from which to query the
--     format properties.
--
-- -   @format@ is the format whose properties are queried.
--
-- -   @pFormatProperties@ is a pointer to a 'VkFormatProperties2'
--     structure in which physical device properties for @format@ are
--     returned.
--
-- = Description
--
-- 'vkGetPhysicalDeviceFormatProperties2' behaves similarly to
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceFormatProperties',
-- with the ability to return extended information in a @pNext@ chain of
-- output structures.
--
-- Unresolved directive in vkGetPhysicalDeviceFormatProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceFormatProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.Core.VkFormat', 'VkFormatProperties2',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceFormatProperties2" vkGetPhysicalDeviceFormatProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("format" ::: VkFormat) -> ("pFormatProperties" ::: Ptr VkFormatProperties2) -> IO ()
#else
vkGetPhysicalDeviceFormatProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("format" ::: VkFormat) -> ("pFormatProperties" ::: Ptr VkFormatProperties2) -> IO ()
vkGetPhysicalDeviceFormatProperties2 deviceCmds = mkVkGetPhysicalDeviceFormatProperties2 (pVkGetPhysicalDeviceFormatProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceFormatProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("format" ::: VkFormat) -> ("pFormatProperties" ::: Ptr VkFormatProperties2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("format" ::: VkFormat) -> ("pFormatProperties" ::: Ptr VkFormatProperties2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceFormatProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("format" ::: VkFormat) -> ("pFormatProperties" ::: Ptr VkFormatProperties2) -> IO ()
type PFN_vkGetPhysicalDeviceFormatProperties2 = FunPtr FN_vkGetPhysicalDeviceFormatProperties2

-- | vkGetPhysicalDeviceImageFormatProperties2 - Lists physical device’s
-- image format capabilities
--
-- = Parameters
--
-- -   @physicalDevice@ is the physical device from which to query the
--     image capabilities.
--
-- -   @pImageFormatInfo@ points to an instance of the
--     'VkPhysicalDeviceImageFormatInfo2' structure, describing the
--     parameters that would be consumed by
--     'Graphics.Vulkan.C.Core10.Image.vkCreateImage'.
--
-- -   @pImageFormatProperties@ points to an instance of the
--     'VkImageFormatProperties2' structure in which capabilities are
--     returned.
--
-- = Description
--
-- 'vkGetPhysicalDeviceImageFormatProperties2' behaves similarly to
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceImageFormatProperties',
-- with the ability to return extended information in a @pNext@ chain of
-- output structures.
--
-- == Valid Usage
--
-- -   If the @pNext@ chain of @pImageFormatProperties@ contains an
--     instance of
--     'Graphics.Vulkan.C.Extensions.VK_ANDROID_external_memory_android_hardware_buffer.VkAndroidHardwareBufferUsageANDROID',
--     the @pNext@ chain of @pImageFormatInfo@ /must/ contain an instance
--     of
--     'Graphics.Vulkan.C.Core11.Promoted_from_VK_KHR_external_memory_capabilities.VkPhysicalDeviceExternalImageFormatInfo'
--     with @handleType@ set to
--     'Graphics.Vulkan.C.Extensions.VK_ANDROID_external_memory_android_hardware_buffer.VK_EXTERNAL_MEMORY_HANDLE_TYPE_ANDROID_HARDWARE_BUFFER_BIT_ANDROID'.
--
-- Unresolved directive in vkGetPhysicalDeviceImageFormatProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceImageFormatProperties2.txt[]
--
-- = See Also
--
-- 'VkImageFormatProperties2',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceImageFormatInfo2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceImageFormatProperties2" vkGetPhysicalDeviceImageFormatProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pImageFormatInfo" ::: Ptr VkPhysicalDeviceImageFormatInfo2) -> ("pImageFormatProperties" ::: Ptr VkImageFormatProperties2) -> IO VkResult
#else
vkGetPhysicalDeviceImageFormatProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pImageFormatInfo" ::: Ptr VkPhysicalDeviceImageFormatInfo2) -> ("pImageFormatProperties" ::: Ptr VkImageFormatProperties2) -> IO VkResult
vkGetPhysicalDeviceImageFormatProperties2 deviceCmds = mkVkGetPhysicalDeviceImageFormatProperties2 (pVkGetPhysicalDeviceImageFormatProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceImageFormatProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pImageFormatInfo" ::: Ptr VkPhysicalDeviceImageFormatInfo2) -> ("pImageFormatProperties" ::: Ptr VkImageFormatProperties2) -> IO VkResult) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pImageFormatInfo" ::: Ptr VkPhysicalDeviceImageFormatInfo2) -> ("pImageFormatProperties" ::: Ptr VkImageFormatProperties2) -> IO VkResult)
#endif

type FN_vkGetPhysicalDeviceImageFormatProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pImageFormatInfo" ::: Ptr VkPhysicalDeviceImageFormatInfo2) -> ("pImageFormatProperties" ::: Ptr VkImageFormatProperties2) -> IO VkResult
type PFN_vkGetPhysicalDeviceImageFormatProperties2 = FunPtr FN_vkGetPhysicalDeviceImageFormatProperties2

-- | vkGetPhysicalDeviceMemoryProperties2 - Reports memory information for
-- the specified physical device
--
-- = Parameters
--
-- -   @physicalDevice@ is the handle to the device to query.
--
-- -   @pMemoryProperties@ points to an instance of
--     'VkPhysicalDeviceMemoryProperties2' structure in which the
--     properties are returned.
--
-- = Description
--
-- 'vkGetPhysicalDeviceMemoryProperties2' behaves similarly to
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceMemoryProperties',
-- with the ability to return extended information in a @pNext@ chain of
-- output structures.
--
-- Unresolved directive in vkGetPhysicalDeviceMemoryProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceMemoryProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceMemoryProperties2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceMemoryProperties2" vkGetPhysicalDeviceMemoryProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pMemoryProperties" ::: Ptr VkPhysicalDeviceMemoryProperties2) -> IO ()
#else
vkGetPhysicalDeviceMemoryProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pMemoryProperties" ::: Ptr VkPhysicalDeviceMemoryProperties2) -> IO ()
vkGetPhysicalDeviceMemoryProperties2 deviceCmds = mkVkGetPhysicalDeviceMemoryProperties2 (pVkGetPhysicalDeviceMemoryProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceMemoryProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pMemoryProperties" ::: Ptr VkPhysicalDeviceMemoryProperties2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pMemoryProperties" ::: Ptr VkPhysicalDeviceMemoryProperties2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceMemoryProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pMemoryProperties" ::: Ptr VkPhysicalDeviceMemoryProperties2) -> IO ()
type PFN_vkGetPhysicalDeviceMemoryProperties2 = FunPtr FN_vkGetPhysicalDeviceMemoryProperties2

-- | vkGetPhysicalDeviceProperties2 - Returns properties of a physical device
--
-- = Parameters
--
-- -   @physicalDevice@ is the handle to the physical device whose
--     properties will be queried.
--
-- -   @pProperties@ points to an instance of the
--     'VkPhysicalDeviceProperties2' structure, that will be filled with
--     returned information.
--
-- = Description
--
-- Each structure in @pProperties@ and its @pNext@ chain contain members
-- corresponding to properties or implementation-dependent limits.
-- 'vkGetPhysicalDeviceProperties2' writes each member to a value
-- indicating the value of that property or limit.
--
-- Unresolved directive in vkGetPhysicalDeviceProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceProperties2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceProperties2" vkGetPhysicalDeviceProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pProperties" ::: Ptr VkPhysicalDeviceProperties2) -> IO ()
#else
vkGetPhysicalDeviceProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pProperties" ::: Ptr VkPhysicalDeviceProperties2) -> IO ()
vkGetPhysicalDeviceProperties2 deviceCmds = mkVkGetPhysicalDeviceProperties2 (pVkGetPhysicalDeviceProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pProperties" ::: Ptr VkPhysicalDeviceProperties2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pProperties" ::: Ptr VkPhysicalDeviceProperties2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pProperties" ::: Ptr VkPhysicalDeviceProperties2) -> IO ()
type PFN_vkGetPhysicalDeviceProperties2 = FunPtr FN_vkGetPhysicalDeviceProperties2

-- | vkGetPhysicalDeviceQueueFamilyProperties2 - Reports properties of the
-- queues of the specified physical device
--
-- = Parameters
--
-- -   @physicalDevice@ is the handle to the physical device whose
--     properties will be queried.
--
-- -   @pQueueFamilyPropertyCount@ is a pointer to an integer related to
--     the number of queue families available or queried, as described in
--     'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceQueueFamilyProperties'.
--
-- -   @pQueueFamilyProperties@ is either @NULL@ or a pointer to an array
--     of 'VkQueueFamilyProperties2' structures.
--
-- = Description
--
-- 'vkGetPhysicalDeviceQueueFamilyProperties2' behaves similarly to
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceQueueFamilyProperties',
-- with the ability to return extended information in a @pNext@ chain of
-- output structures.
--
-- Unresolved directive in vkGetPhysicalDeviceQueueFamilyProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceQueueFamilyProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkQueueFamilyProperties2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceQueueFamilyProperties2" vkGetPhysicalDeviceQueueFamilyProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pQueueFamilyPropertyCount" ::: Ptr Word32) -> ("pQueueFamilyProperties" ::: Ptr VkQueueFamilyProperties2) -> IO ()
#else
vkGetPhysicalDeviceQueueFamilyProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pQueueFamilyPropertyCount" ::: Ptr Word32) -> ("pQueueFamilyProperties" ::: Ptr VkQueueFamilyProperties2) -> IO ()
vkGetPhysicalDeviceQueueFamilyProperties2 deviceCmds = mkVkGetPhysicalDeviceQueueFamilyProperties2 (pVkGetPhysicalDeviceQueueFamilyProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceQueueFamilyProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pQueueFamilyPropertyCount" ::: Ptr Word32) -> ("pQueueFamilyProperties" ::: Ptr VkQueueFamilyProperties2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pQueueFamilyPropertyCount" ::: Ptr Word32) -> ("pQueueFamilyProperties" ::: Ptr VkQueueFamilyProperties2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceQueueFamilyProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pQueueFamilyPropertyCount" ::: Ptr Word32) -> ("pQueueFamilyProperties" ::: Ptr VkQueueFamilyProperties2) -> IO ()
type PFN_vkGetPhysicalDeviceQueueFamilyProperties2 = FunPtr FN_vkGetPhysicalDeviceQueueFamilyProperties2

-- | vkGetPhysicalDeviceSparseImageFormatProperties2 - Retrieve properties of
-- an image format applied to sparse images
--
-- = Parameters
--
-- -   @physicalDevice@ is the physical device from which to query the
--     sparse image capabilities.
--
-- -   @pFormatInfo@ is a pointer to a structure of type
--     'VkPhysicalDeviceSparseImageFormatInfo2' containing input parameters
--     to the command.
--
-- -   @pPropertyCount@ is a pointer to an integer related to the number of
--     sparse format properties available or queried, as described below.
--
-- -   @pProperties@ is either @NULL@ or a pointer to an array of
--     'VkSparseImageFormatProperties2' structures.
--
-- = Description
--
-- 'vkGetPhysicalDeviceSparseImageFormatProperties2' behaves identically to
-- 'Graphics.Vulkan.C.Core10.SparseResourceMemoryManagement.vkGetPhysicalDeviceSparseImageFormatProperties',
-- with the ability to return extended information by adding extension
-- structures to the @pNext@ chain of its @pProperties@ parameter.
--
-- Unresolved directive in
-- vkGetPhysicalDeviceSparseImageFormatProperties2.txt -
-- include::{generated}\/validity\/protos\/vkGetPhysicalDeviceSparseImageFormatProperties2.txt[]
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceSparseImageFormatInfo2',
-- 'VkSparseImageFormatProperties2'
#if defined(EXPOSE_CORE11_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceSparseImageFormatProperties2" vkGetPhysicalDeviceSparseImageFormatProperties2 :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pFormatInfo" ::: Ptr VkPhysicalDeviceSparseImageFormatInfo2) -> ("pPropertyCount" ::: Ptr Word32) -> ("pProperties" ::: Ptr VkSparseImageFormatProperties2) -> IO ()
#else
vkGetPhysicalDeviceSparseImageFormatProperties2 :: InstanceCmds -> ("physicalDevice" ::: VkPhysicalDevice) -> ("pFormatInfo" ::: Ptr VkPhysicalDeviceSparseImageFormatInfo2) -> ("pPropertyCount" ::: Ptr Word32) -> ("pProperties" ::: Ptr VkSparseImageFormatProperties2) -> IO ()
vkGetPhysicalDeviceSparseImageFormatProperties2 deviceCmds = mkVkGetPhysicalDeviceSparseImageFormatProperties2 (pVkGetPhysicalDeviceSparseImageFormatProperties2 deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetPhysicalDeviceSparseImageFormatProperties2
  :: FunPtr (("physicalDevice" ::: VkPhysicalDevice) -> ("pFormatInfo" ::: Ptr VkPhysicalDeviceSparseImageFormatInfo2) -> ("pPropertyCount" ::: Ptr Word32) -> ("pProperties" ::: Ptr VkSparseImageFormatProperties2) -> IO ()) -> (("physicalDevice" ::: VkPhysicalDevice) -> ("pFormatInfo" ::: Ptr VkPhysicalDeviceSparseImageFormatInfo2) -> ("pPropertyCount" ::: Ptr Word32) -> ("pProperties" ::: Ptr VkSparseImageFormatProperties2) -> IO ())
#endif

type FN_vkGetPhysicalDeviceSparseImageFormatProperties2 = ("physicalDevice" ::: VkPhysicalDevice) -> ("pFormatInfo" ::: Ptr VkPhysicalDeviceSparseImageFormatInfo2) -> ("pPropertyCount" ::: Ptr Word32) -> ("pProperties" ::: Ptr VkSparseImageFormatProperties2) -> IO ()
type PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 = FunPtr FN_vkGetPhysicalDeviceSparseImageFormatProperties2

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_FORMAT_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_FORMAT_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_FORMAT_PROPERTIES_2 = VkStructureType 1000059002

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_IMAGE_FORMAT_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_IMAGE_FORMAT_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_IMAGE_FORMAT_PROPERTIES_2 = VkStructureType 1000059003

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 = VkStructureType 1000059000

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2 = VkStructureType 1000059004

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PROPERTIES_2 = VkStructureType 1000059006

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2 = VkStructureType 1000059001

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2 = VkStructureType 1000059008

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_QUEUE_FAMILY_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_QUEUE_FAMILY_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_QUEUE_FAMILY_PROPERTIES_2 = VkStructureType 1000059005

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_SPARSE_IMAGE_FORMAT_PROPERTIES_2"
pattern VK_STRUCTURE_TYPE_SPARSE_IMAGE_FORMAT_PROPERTIES_2 :: VkStructureType
pattern VK_STRUCTURE_TYPE_SPARSE_IMAGE_FORMAT_PROPERTIES_2 = VkStructureType 1000059007
