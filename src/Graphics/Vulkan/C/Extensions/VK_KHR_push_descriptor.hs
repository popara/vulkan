{-# language Strict #-}
{-# language CPP #-}
{-# language DuplicateRecordFields #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}

module Graphics.Vulkan.C.Extensions.VK_KHR_push_descriptor
  ( VkPhysicalDevicePushDescriptorPropertiesKHR(..)
  , FN_vkCmdPushDescriptorSetKHR
  , PFN_vkCmdPushDescriptorSetKHR
  , vkCmdPushDescriptorSetKHR
  , FN_vkCmdPushDescriptorSetWithTemplateKHR
  , PFN_vkCmdPushDescriptorSetWithTemplateKHR
  , vkCmdPushDescriptorSetWithTemplateKHR
  , pattern VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR
  , pattern VK_DESCRIPTOR_UPDATE_TEMPLATE_TYPE_PUSH_DESCRIPTORS_KHR
  , pattern VK_KHR_PUSH_DESCRIPTOR_EXTENSION_NAME
  , pattern VK_KHR_PUSH_DESCRIPTOR_SPEC_VERSION
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR
  ) where

import Data.String
  ( IsString
  )
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
  ( VkStructureType(..)
  , Zero(..)
  )
import Graphics.Vulkan.C.Core10.DescriptorSet
  ( VkDescriptorSetLayoutCreateFlagBits(..)
  , VkWriteDescriptorSet(..)
  )
import Graphics.Vulkan.C.Core10.Pass
  ( VkPipelineBindPoint(..)
  )
import Graphics.Vulkan.C.Core10.Pipeline
  ( VkPipelineLayout
  )
import Graphics.Vulkan.C.Core10.Queue
  ( VkCommandBuffer
  )
import Graphics.Vulkan.C.Core11.Promoted_from_VK_KHR_descriptor_update_template
  ( VkDescriptorUpdateTemplateType(..)
  , VkDescriptorUpdateTemplate
  )
import Graphics.Vulkan.C.Dynamic
  ( DeviceCmds(..)
  )
import Graphics.Vulkan.NamedType
  ( (:::)
  )


-- | VkPhysicalDevicePushDescriptorPropertiesKHR - Structure describing push
-- descriptor limits that can be supported by an implementation
--
-- = Members
--
-- The members of the 'VkPhysicalDevicePushDescriptorPropertiesKHR'
-- structure describe the following implementation-dependent limits:
--
-- = Description
--
-- If the 'VkPhysicalDevicePushDescriptorPropertiesKHR' structure is
-- included in the @pNext@ chain of
-- 'Graphics.Vulkan.C.Core11.Promoted_from_VK_KHR_get_physical_device_properties2.VkPhysicalDeviceProperties2',
-- it is filled with the implementation-dependent limits.
--
-- Unresolved directive in VkPhysicalDevicePushDescriptorPropertiesKHR.txt
-- -
-- include::{generated}\/validity\/structs\/VkPhysicalDevicePushDescriptorPropertiesKHR.txt[]
--
-- = See Also
--
-- No cross-references are available
data VkPhysicalDevicePushDescriptorPropertiesKHR = VkPhysicalDevicePushDescriptorPropertiesKHR
  { -- | @sType@ is the type of this structure.
  vkSType :: VkStructureType
  , -- | @pNext@ is @NULL@ or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @maxPushDescriptors@ is the maximum number of descriptors that /can/ be
  -- used in a descriptor set created with
  -- 'VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR' set.
  vkMaxPushDescriptors :: Word32
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDevicePushDescriptorPropertiesKHR where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek ptr = VkPhysicalDevicePushDescriptorPropertiesKHR <$> peek (ptr `plusPtr` 0)
                                                         <*> peek (ptr `plusPtr` 8)
                                                         <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDevicePushDescriptorPropertiesKHR))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDevicePushDescriptorPropertiesKHR))
                *> poke (ptr `plusPtr` 16) (vkMaxPushDescriptors (poked :: VkPhysicalDevicePushDescriptorPropertiesKHR))

instance Zero VkPhysicalDevicePushDescriptorPropertiesKHR where
  zero = VkPhysicalDevicePushDescriptorPropertiesKHR VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR
                                                     zero
                                                     zero

-- | vkCmdPushDescriptorSetKHR - Pushes descriptor updates into a command
-- buffer
--
-- = Parameters
--
-- -   @commandBuffer@ is the command buffer that the descriptors will be
--     recorded in.
--
-- -   @pipelineBindPoint@ is a
--     'Graphics.Vulkan.C.Core10.Pass.VkPipelineBindPoint' indicating
--     whether the descriptors will be used by graphics pipelines or
--     compute pipelines. There is a separate set of push descriptor
--     bindings for each of graphics and compute, so binding one does not
--     disturb the other.
--
-- -   @layout@ is a 'Graphics.Vulkan.C.Core10.Pipeline.VkPipelineLayout'
--     object used to program the bindings.
--
-- -   @set@ is the set number of the descriptor set in the pipeline layout
--     that will be updated.
--
-- -   @descriptorWriteCount@ is the number of elements in the
--     @pDescriptorWrites@ array.
--
-- -   @pDescriptorWrites@ is a pointer to an array of
--     'Graphics.Vulkan.C.Core10.DescriptorSet.VkWriteDescriptorSet'
--     structures describing the descriptors to be updated.
--
-- = Description
--
-- /Push descriptors/ are a small bank of descriptors whose storage is
-- internally managed by the command buffer rather than being written into
-- a descriptor set and later bound to a command buffer. Push descriptors
-- allow for incremental updates of descriptors without managing the
-- lifetime of descriptor sets.
--
-- When a command buffer begins recording, all push descriptors are
-- undefined. Push descriptors /can/ be updated incrementally and cause
-- shaders to use the updated descriptors for subsequent rendering commands
-- (either compute or graphics, according to the @pipelineBindPoint@) until
-- the descriptor is overwritten, or else until the set is disturbed as
-- described in
-- <https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html#descriptorsets-compatibility Pipeline Layout Compatibility>.
-- When the set is disturbed or push descriptors with a different
-- descriptor set layout are set, all push descriptors are undefined.
--
-- Push descriptors that are
-- <https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html#shaders-staticuse statically used>
-- by a pipeline /must/ not be undefined at the time that a draw or
-- dispatch command is recorded to execute using that pipeline. This
-- includes immutable sampler descriptors, which /must/ be pushed before
-- they are accessed by a pipeline. Push descriptors that are not
-- statically used /can/ remain undefined.
--
-- Push descriptors do not use dynamic offsets. Instead, the corresponding
-- non-dynamic descriptor types /can/ be used and the @offset@ member of
-- 'Graphics.Vulkan.C.Core10.DescriptorSet.VkDescriptorBufferInfo' /can/ be
-- changed each time the descriptor is written.
--
-- Each element of @pDescriptorWrites@ is interpreted as in
-- 'Graphics.Vulkan.C.Core10.DescriptorSet.VkWriteDescriptorSet', except
-- the @dstSet@ member is ignored.
--
-- To push an immutable sampler, use a
-- 'Graphics.Vulkan.C.Core10.DescriptorSet.VkWriteDescriptorSet' with
-- @dstBinding@ and @dstArrayElement@ selecting the immutable sampler’s
-- binding. If the descriptor type is
-- 'Graphics.Vulkan.C.Core10.DescriptorSet.VK_DESCRIPTOR_TYPE_SAMPLER', the
-- @pImageInfo@ parameter is ignored and the immutable sampler is taken
-- from the push descriptor set layout in the pipeline layout. If the
-- descriptor type is
-- 'Graphics.Vulkan.C.Core10.DescriptorSet.VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER',
-- the @sampler@ member of the @pImageInfo@ parameter is ignored and the
-- immutable sampler is taken from the push descriptor set layout in the
-- pipeline layout.
--
-- == Valid Usage
--
-- Unresolved directive in vkCmdPushDescriptorSetKHR.txt -
-- include::{generated}\/validity\/protos\/vkCmdPushDescriptorSetKHR.txt[]
--
-- = See Also
--
-- No cross-references are available
#if defined(EXPOSE_STATIC_EXTENSION_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkCmdPushDescriptorSetKHR" vkCmdPushDescriptorSetKHR :: ("commandBuffer" ::: VkCommandBuffer) -> ("pipelineBindPoint" ::: VkPipelineBindPoint) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("descriptorWriteCount" ::: Word32) -> ("pDescriptorWrites" ::: Ptr VkWriteDescriptorSet) -> IO ()
#else
vkCmdPushDescriptorSetKHR :: DeviceCmds -> ("commandBuffer" ::: VkCommandBuffer) -> ("pipelineBindPoint" ::: VkPipelineBindPoint) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("descriptorWriteCount" ::: Word32) -> ("pDescriptorWrites" ::: Ptr VkWriteDescriptorSet) -> IO ()
vkCmdPushDescriptorSetKHR deviceCmds = mkVkCmdPushDescriptorSetKHR (pVkCmdPushDescriptorSetKHR deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkCmdPushDescriptorSetKHR
  :: FunPtr (("commandBuffer" ::: VkCommandBuffer) -> ("pipelineBindPoint" ::: VkPipelineBindPoint) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("descriptorWriteCount" ::: Word32) -> ("pDescriptorWrites" ::: Ptr VkWriteDescriptorSet) -> IO ()) -> (("commandBuffer" ::: VkCommandBuffer) -> ("pipelineBindPoint" ::: VkPipelineBindPoint) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("descriptorWriteCount" ::: Word32) -> ("pDescriptorWrites" ::: Ptr VkWriteDescriptorSet) -> IO ())
#endif

type FN_vkCmdPushDescriptorSetKHR = ("commandBuffer" ::: VkCommandBuffer) -> ("pipelineBindPoint" ::: VkPipelineBindPoint) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("descriptorWriteCount" ::: Word32) -> ("pDescriptorWrites" ::: Ptr VkWriteDescriptorSet) -> IO ()
type PFN_vkCmdPushDescriptorSetKHR = FunPtr FN_vkCmdPushDescriptorSetKHR

-- | vkCmdPushDescriptorSetWithTemplateKHR - Pushes descriptor updates into a
-- command buffer using a descriptor update template
--
-- = Parameters
--
-- -   @commandBuffer@ is the command buffer that the descriptors will be
--     recorded in.
--
-- -   @descriptorUpdateTemplate@ is a descriptor update template that
--     defines how to interpret the descriptor information in @pData@.
--
-- -   @layout@ is a 'Graphics.Vulkan.C.Core10.Pipeline.VkPipelineLayout'
--     object used to program the bindings. It /must/ be compatible with
--     the layout used to create the @descriptorUpdateTemplate@ handle.
--
-- -   @set@ is the set number of the descriptor set in the pipeline layout
--     that will be updated. This /must/ be the same number used to create
--     the @descriptorUpdateTemplate@ handle.
--
-- -   @pData@ points to memory which contains the descriptors for the
--     templated update.
--
-- == Valid Usage
--
-- -   The @pipelineBindPoint@ specified during the creation of the
--     descriptor update template /must/ be supported by the
--     @commandBuffer@’s parent
--     'Graphics.Vulkan.C.Core10.CommandPool.VkCommandPool'’s queue family
--
-- -   @pData@ /must/ be a valid pointer to a memory that contains one or
--     more valid instances of
--     'Graphics.Vulkan.C.Core10.DescriptorSet.VkDescriptorImageInfo',
--     'Graphics.Vulkan.C.Core10.DescriptorSet.VkDescriptorBufferInfo', or
--     'Graphics.Vulkan.C.Core10.BufferView.VkBufferView' in a layout
--     defined by @descriptorUpdateTemplate@ when it was created with
--     'Graphics.Vulkan.C.Extensions.VK_KHR_descriptor_update_template.vkCreateDescriptorUpdateTemplateKHR'
--
-- Unresolved directive in vkCmdPushDescriptorSetWithTemplateKHR.txt -
-- include::{generated}\/validity\/protos\/vkCmdPushDescriptorSetWithTemplateKHR.txt[]
--
-- __API example.__
--
-- > struct AppDataStructure
-- > {
-- >     VkDescriptorImageInfo  imageInfo;          // a single image info
-- >     // ... some more application related data
-- > };
-- >
-- > const VkDescriptorUpdateTemplateEntry descriptorUpdateTemplateEntries[] =
-- > {
-- >     // binding to a single image descriptor
-- >     {
-- >         0,                                           // binding
-- >         0,                                           // dstArrayElement
-- >         1,                                           // descriptorCount
-- >         VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,   // descriptorType
-- >         offsetof(AppDataStructure, imageInfo),       // offset
-- >         0                                            // stride is not required if descriptorCount is 1
-- >     }
-- > };
-- >
-- > // create a descriptor update template for descriptor set updates
-- > const VkDescriptorUpdateTemplateCreateInfo createInfo =
-- > {
-- >     VK_STRUCTURE_TYPE_DESCRIPTOR_UPDATE_TEMPLATE_CREATE_INFO,  // sType
-- >     NULL,                                                      // pNext
-- >     0,                                                         // flags
-- >     1,                                                         // descriptorUpdateEntryCount
-- >     descriptorUpdateTemplateEntries,                           // pDescriptorUpdateEntries
-- >     VK_DESCRIPTOR_UPDATE_TEMPLATE_TYPE_PUSH_DESCRIPTORS_KHR,   // templateType
-- >     0,                                                         // descriptorSetLayout, ignored by given templateType
-- >     VK_PIPELINE_BIND_POINT_GRAPHICS,                           // pipelineBindPoint
-- >     myPipelineLayout,                                          // pipelineLayout
-- >     0,                                                         // set
-- > };
-- >
-- > VkDescriptorUpdateTemplate myDescriptorUpdateTemplate;
-- > myResult = vkCreateDescriptorUpdateTemplate(
-- >     myDevice,
-- >     &createInfo,
-- >     NULL,
-- >     &myDescriptorUpdateTemplate);
-- > }
-- >
-- > AppDataStructure appData;
-- > // fill appData here or cache it in your engine
-- > vkCmdPushDescriptorSetWithTemplateKHR(myCmdBuffer, myDescriptorUpdateTemplate, myPipelineLayout, 0,&appData);
--
-- = See Also
--
-- No cross-references are available
#if defined(EXPOSE_STATIC_EXTENSION_COMMANDS)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkCmdPushDescriptorSetWithTemplateKHR" vkCmdPushDescriptorSetWithTemplateKHR :: ("commandBuffer" ::: VkCommandBuffer) -> ("descriptorUpdateTemplate" ::: VkDescriptorUpdateTemplate) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("pData" ::: Ptr ()) -> IO ()
#else
vkCmdPushDescriptorSetWithTemplateKHR :: DeviceCmds -> ("commandBuffer" ::: VkCommandBuffer) -> ("descriptorUpdateTemplate" ::: VkDescriptorUpdateTemplate) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("pData" ::: Ptr ()) -> IO ()
vkCmdPushDescriptorSetWithTemplateKHR deviceCmds = mkVkCmdPushDescriptorSetWithTemplateKHR (pVkCmdPushDescriptorSetWithTemplateKHR deviceCmds)
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkCmdPushDescriptorSetWithTemplateKHR
  :: FunPtr (("commandBuffer" ::: VkCommandBuffer) -> ("descriptorUpdateTemplate" ::: VkDescriptorUpdateTemplate) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("pData" ::: Ptr ()) -> IO ()) -> (("commandBuffer" ::: VkCommandBuffer) -> ("descriptorUpdateTemplate" ::: VkDescriptorUpdateTemplate) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("pData" ::: Ptr ()) -> IO ())
#endif

type FN_vkCmdPushDescriptorSetWithTemplateKHR = ("commandBuffer" ::: VkCommandBuffer) -> ("descriptorUpdateTemplate" ::: VkDescriptorUpdateTemplate) -> ("layout" ::: VkPipelineLayout) -> ("set" ::: Word32) -> ("pData" ::: Ptr ()) -> IO ()
type PFN_vkCmdPushDescriptorSetWithTemplateKHR = FunPtr FN_vkCmdPushDescriptorSetWithTemplateKHR

-- | 'VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR' specifies that
-- descriptor sets /must/ not be allocated using this layout, and
-- descriptors are instead pushed by 'vkCmdPushDescriptorSetKHR'.
pattern VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR :: VkDescriptorSetLayoutCreateFlagBits
pattern VK_DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR = VkDescriptorSetLayoutCreateFlagBits 0x00000001

-- | 'VK_DESCRIPTOR_UPDATE_TEMPLATE_TYPE_PUSH_DESCRIPTORS_KHR' specifies that
-- the descriptor update template will be used for push descriptor updates
-- only.
pattern VK_DESCRIPTOR_UPDATE_TEMPLATE_TYPE_PUSH_DESCRIPTORS_KHR :: VkDescriptorUpdateTemplateType
pattern VK_DESCRIPTOR_UPDATE_TEMPLATE_TYPE_PUSH_DESCRIPTORS_KHR = VkDescriptorUpdateTemplateType 1

-- No documentation found for TopLevel "VK_KHR_PUSH_DESCRIPTOR_EXTENSION_NAME"
pattern VK_KHR_PUSH_DESCRIPTOR_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_KHR_PUSH_DESCRIPTOR_EXTENSION_NAME = "VK_KHR_push_descriptor"

-- No documentation found for TopLevel "VK_KHR_PUSH_DESCRIPTOR_SPEC_VERSION"
pattern VK_KHR_PUSH_DESCRIPTOR_SPEC_VERSION :: Integral a => a
pattern VK_KHR_PUSH_DESCRIPTOR_SPEC_VERSION = 2

-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR = VkStructureType 1000080000
