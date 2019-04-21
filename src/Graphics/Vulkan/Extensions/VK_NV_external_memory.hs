{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}
{-# language DuplicateRecordFields #-}

module Graphics.Vulkan.Extensions.VK_NV_external_memory
  ( withCStructExportMemoryAllocateInfoNV
  , fromCStructExportMemoryAllocateInfoNV
  , ExportMemoryAllocateInfoNV(..)
  , withCStructExternalMemoryImageCreateInfoNV
  , fromCStructExternalMemoryImageCreateInfoNV
  , ExternalMemoryImageCreateInfoNV(..)
  , pattern VK_NV_EXTERNAL_MEMORY_SPEC_VERSION
  , pattern VK_NV_EXTERNAL_MEMORY_EXTENSION_NAME
  , pattern VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV
  , pattern VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO_NV
  ) where

import Foreign.Marshal.Utils
  ( maybePeek
  , maybeWith
  )
import Foreign.Ptr
  ( castPtr
  )


import Graphics.Vulkan.C.Core10.Core
  ( Zero(..)
  )
import Graphics.Vulkan.C.Extensions.VK_NV_external_memory
  ( VkExportMemoryAllocateInfoNV(..)
  , VkExternalMemoryImageCreateInfoNV(..)
  , pattern VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO_NV
  , pattern VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV
  )
import Graphics.Vulkan.Extensions.VK_NV_external_memory_capabilities
  ( ExternalMemoryHandleTypeFlagsNV
  )
import {-# source #-} Graphics.Vulkan.Marshal.SomeVkStruct
  ( SomeVkStruct
  , peekVkStruct
  , withSomeVkStruct
  )
import Graphics.Vulkan.C.Extensions.VK_NV_external_memory
  ( pattern VK_NV_EXTERNAL_MEMORY_EXTENSION_NAME
  , pattern VK_NV_EXTERNAL_MEMORY_SPEC_VERSION
  )



-- | VkExportMemoryAllocateInfoNV - Specify memory handle types that may be
-- exported
--
-- = Description
--
-- Unresolved directive in VkExportMemoryAllocateInfoNV.txt -
-- include::{generated}\/validity\/structs\/VkExportMemoryAllocateInfoNV.txt[]
--
-- = See Also
--
-- No cross-references are available
data ExportMemoryAllocateInfoNV = ExportMemoryAllocateInfoNV
  { -- Univalued member elided
  -- No documentation found for Nested "ExportMemoryAllocateInfoNV" "pNext"
  next :: Maybe SomeVkStruct
  , -- No documentation found for Nested "ExportMemoryAllocateInfoNV" "handleTypes"
  handleTypes :: ExternalMemoryHandleTypeFlagsNV
  }
  deriving (Show, Eq)

-- | A function to temporarily allocate memory for a 'VkExportMemoryAllocateInfoNV' and
-- marshal a 'ExportMemoryAllocateInfoNV' into it. The 'VkExportMemoryAllocateInfoNV' is only valid inside
-- the provided computation and must not be returned out of it.
withCStructExportMemoryAllocateInfoNV :: ExportMemoryAllocateInfoNV -> (VkExportMemoryAllocateInfoNV -> IO a) -> IO a
withCStructExportMemoryAllocateInfoNV marshalled cont = maybeWith withSomeVkStruct (next (marshalled :: ExportMemoryAllocateInfoNV)) (\pPNext -> cont (VkExportMemoryAllocateInfoNV VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO_NV pPNext (handleTypes (marshalled :: ExportMemoryAllocateInfoNV))))

-- | A function to read a 'VkExportMemoryAllocateInfoNV' and all additional
-- structures in the pointer chain into a 'ExportMemoryAllocateInfoNV'.
fromCStructExportMemoryAllocateInfoNV :: VkExportMemoryAllocateInfoNV -> IO ExportMemoryAllocateInfoNV
fromCStructExportMemoryAllocateInfoNV c = ExportMemoryAllocateInfoNV <$> -- Univalued Member elided
                                                                     maybePeek peekVkStruct (castPtr (vkPNext (c :: VkExportMemoryAllocateInfoNV)))
                                                                     <*> pure (vkHandleTypes (c :: VkExportMemoryAllocateInfoNV))

instance Zero ExportMemoryAllocateInfoNV where
  zero = ExportMemoryAllocateInfoNV Nothing
                                    zero



-- | VkExternalMemoryImageCreateInfoNV - Specify that an image may be backed
-- by external memory
--
-- = Description
--
-- Unresolved directive in VkExternalMemoryImageCreateInfoNV.txt -
-- include::{generated}\/validity\/structs\/VkExternalMemoryImageCreateInfoNV.txt[]
--
-- = See Also
--
-- No cross-references are available
data ExternalMemoryImageCreateInfoNV = ExternalMemoryImageCreateInfoNV
  { -- Univalued member elided
  -- No documentation found for Nested "ExternalMemoryImageCreateInfoNV" "pNext"
  next :: Maybe SomeVkStruct
  , -- No documentation found for Nested "ExternalMemoryImageCreateInfoNV" "handleTypes"
  handleTypes :: ExternalMemoryHandleTypeFlagsNV
  }
  deriving (Show, Eq)

-- | A function to temporarily allocate memory for a 'VkExternalMemoryImageCreateInfoNV' and
-- marshal a 'ExternalMemoryImageCreateInfoNV' into it. The 'VkExternalMemoryImageCreateInfoNV' is only valid inside
-- the provided computation and must not be returned out of it.
withCStructExternalMemoryImageCreateInfoNV :: ExternalMemoryImageCreateInfoNV -> (VkExternalMemoryImageCreateInfoNV -> IO a) -> IO a
withCStructExternalMemoryImageCreateInfoNV marshalled cont = maybeWith withSomeVkStruct (next (marshalled :: ExternalMemoryImageCreateInfoNV)) (\pPNext -> cont (VkExternalMemoryImageCreateInfoNV VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV pPNext (handleTypes (marshalled :: ExternalMemoryImageCreateInfoNV))))

-- | A function to read a 'VkExternalMemoryImageCreateInfoNV' and all additional
-- structures in the pointer chain into a 'ExternalMemoryImageCreateInfoNV'.
fromCStructExternalMemoryImageCreateInfoNV :: VkExternalMemoryImageCreateInfoNV -> IO ExternalMemoryImageCreateInfoNV
fromCStructExternalMemoryImageCreateInfoNV c = ExternalMemoryImageCreateInfoNV <$> -- Univalued Member elided
                                                                               maybePeek peekVkStruct (castPtr (vkPNext (c :: VkExternalMemoryImageCreateInfoNV)))
                                                                               <*> pure (vkHandleTypes (c :: VkExternalMemoryImageCreateInfoNV))

instance Zero ExternalMemoryImageCreateInfoNV where
  zero = ExternalMemoryImageCreateInfoNV Nothing
                                         zero

