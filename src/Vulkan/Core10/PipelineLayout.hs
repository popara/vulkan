{-# language CPP #-}
module Vulkan.Core10.PipelineLayout  ( createPipelineLayout
                                     , withPipelineLayout
                                     , destroyPipelineLayout
                                     , PushConstantRange(..)
                                     , PipelineLayoutCreateInfo(..)
                                     , PipelineLayout(..)
                                     ) where

import Control.Exception.Base (bracket)
import Control.Monad (unless)
import Control.Monad.IO.Class (liftIO)
import Foreign.Marshal.Alloc (allocaBytesAligned)
import Foreign.Marshal.Alloc (callocBytes)
import Foreign.Marshal.Alloc (free)
import GHC.Base (when)
import GHC.IO (throwIO)
import GHC.Ptr (nullFunPtr)
import Foreign.Ptr (nullPtr)
import Foreign.Ptr (plusPtr)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Cont (evalContT)
import Data.Vector (generateM)
import qualified Data.Vector (imapM_)
import qualified Data.Vector (length)
import Control.Monad.IO.Class (MonadIO)
import Data.Typeable (Typeable)
import Foreign.Storable (Storable)
import Foreign.Storable (Storable(peek))
import Foreign.Storable (Storable(poke))
import qualified Foreign.Storable (Storable(..))
import GHC.Generics (Generic)
import GHC.IO.Exception (IOErrorType(..))
import GHC.IO.Exception (IOException(..))
import Foreign.Ptr (FunPtr)
import Foreign.Ptr (Ptr)
import Data.Word (Word32)
import Data.Kind (Type)
import Control.Monad.Trans.Cont (ContT(..))
import Data.Vector (Vector)
import Vulkan.CStruct.Utils (advancePtrBytes)
import Vulkan.NamedType ((:::))
import Vulkan.Core10.AllocationCallbacks (AllocationCallbacks)
import Vulkan.Core10.Handles (DescriptorSetLayout)
import Vulkan.Core10.Handles (Device)
import Vulkan.Core10.Handles (Device(..))
import Vulkan.Dynamic (DeviceCmds(pVkCreatePipelineLayout))
import Vulkan.Dynamic (DeviceCmds(pVkDestroyPipelineLayout))
import Vulkan.Core10.Handles (Device_T)
import Vulkan.CStruct (FromCStruct)
import Vulkan.CStruct (FromCStruct(..))
import Vulkan.Core10.Handles (PipelineLayout)
import Vulkan.Core10.Handles (PipelineLayout(..))
import Vulkan.Core10.Enums.PipelineLayoutCreateFlags (PipelineLayoutCreateFlags)
import Vulkan.Core10.Enums.Result (Result)
import Vulkan.Core10.Enums.Result (Result(..))
import Vulkan.Core10.Enums.ShaderStageFlagBits (ShaderStageFlags)
import Vulkan.Core10.Enums.StructureType (StructureType)
import Vulkan.CStruct (ToCStruct)
import Vulkan.CStruct (ToCStruct(..))
import Vulkan.Exception (VulkanException(..))
import Vulkan.Zero (Zero(..))
import Vulkan.Core10.Enums.StructureType (StructureType(STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO))
import Vulkan.Core10.Enums.Result (Result(SUCCESS))
import Vulkan.Core10.Handles (PipelineLayout(..))
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkCreatePipelineLayout
  :: FunPtr (Ptr Device_T -> Ptr PipelineLayoutCreateInfo -> Ptr AllocationCallbacks -> Ptr PipelineLayout -> IO Result) -> Ptr Device_T -> Ptr PipelineLayoutCreateInfo -> Ptr AllocationCallbacks -> Ptr PipelineLayout -> IO Result

-- | vkCreatePipelineLayout - Creates a new pipeline layout object
--
-- == Valid Usage (Implicit)
--
-- -   @device@ /must/ be a valid 'Vulkan.Core10.Handles.Device' handle
--
-- -   @pCreateInfo@ /must/ be a valid pointer to a valid
--     'PipelineLayoutCreateInfo' structure
--
-- -   If @pAllocator@ is not @NULL@, @pAllocator@ /must/ be a valid
--     pointer to a valid
--     'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks' structure
--
-- -   @pPipelineLayout@ /must/ be a valid pointer to a
--     'Vulkan.Core10.Handles.PipelineLayout' handle
--
-- == Return Codes
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-successcodes Success>]
--
--     -   'Vulkan.Core10.Enums.Result.SUCCESS'
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-errorcodes Failure>]
--
--     -   'Vulkan.Core10.Enums.Result.ERROR_OUT_OF_HOST_MEMORY'
--
--     -   'Vulkan.Core10.Enums.Result.ERROR_OUT_OF_DEVICE_MEMORY'
--
-- = See Also
--
-- 'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks',
-- 'Vulkan.Core10.Handles.Device', 'Vulkan.Core10.Handles.PipelineLayout',
-- 'PipelineLayoutCreateInfo'
createPipelineLayout :: forall io
                      . (MonadIO io)
                     => -- | @device@ is the logical device that creates the pipeline layout.
                        Device
                     -> -- | @pCreateInfo@ is a pointer to a 'PipelineLayoutCreateInfo' structure
                        -- specifying the state of the pipeline layout object.
                        PipelineLayoutCreateInfo
                     -> -- | @pAllocator@ controls host memory allocation as described in the
                        -- <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#memory-allocation Memory Allocation>
                        -- chapter.
                        ("allocator" ::: Maybe AllocationCallbacks)
                     -> io (PipelineLayout)
createPipelineLayout device createInfo allocator = liftIO . evalContT $ do
  let vkCreatePipelineLayoutPtr = pVkCreatePipelineLayout (deviceCmds (device :: Device))
  lift $ unless (vkCreatePipelineLayoutPtr /= nullFunPtr) $
    throwIO $ IOError Nothing InvalidArgument "" "The function pointer for vkCreatePipelineLayout is null" Nothing Nothing
  let vkCreatePipelineLayout' = mkVkCreatePipelineLayout vkCreatePipelineLayoutPtr
  pCreateInfo <- ContT $ withCStruct (createInfo)
  pAllocator <- case (allocator) of
    Nothing -> pure nullPtr
    Just j -> ContT $ withCStruct (j)
  pPPipelineLayout <- ContT $ bracket (callocBytes @PipelineLayout 8) free
  r <- lift $ vkCreatePipelineLayout' (deviceHandle (device)) pCreateInfo pAllocator (pPPipelineLayout)
  lift $ when (r < SUCCESS) (throwIO (VulkanException r))
  pPipelineLayout <- lift $ peek @PipelineLayout pPPipelineLayout
  pure $ (pPipelineLayout)

-- | A convenience wrapper to make a compatible pair of calls to
-- 'createPipelineLayout' and 'destroyPipelineLayout'
--
-- To ensure that 'destroyPipelineLayout' is always called: pass
-- 'Control.Exception.bracket' (or the allocate function from your
-- favourite resource management library) as the first argument.
-- To just extract the pair pass '(,)' as the first argument.
--
withPipelineLayout :: forall io r . MonadIO io => Device -> PipelineLayoutCreateInfo -> Maybe AllocationCallbacks -> (io (PipelineLayout) -> ((PipelineLayout) -> io ()) -> r) -> r
withPipelineLayout device pCreateInfo pAllocator b =
  b (createPipelineLayout device pCreateInfo pAllocator)
    (\(o0) -> destroyPipelineLayout device o0 pAllocator)


foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkDestroyPipelineLayout
  :: FunPtr (Ptr Device_T -> PipelineLayout -> Ptr AllocationCallbacks -> IO ()) -> Ptr Device_T -> PipelineLayout -> Ptr AllocationCallbacks -> IO ()

-- | vkDestroyPipelineLayout - Destroy a pipeline layout object
--
-- == Valid Usage
--
-- -   If 'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks' were
--     provided when @pipelineLayout@ was created, a compatible set of
--     callbacks /must/ be provided here
--
-- -   If no 'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks' were
--     provided when @pipelineLayout@ was created, @pAllocator@ /must/ be
--     @NULL@
--
-- -   @pipelineLayout@ /must/ not have been passed to any @vkCmd*@ command
--     for any command buffers that are still in the
--     <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#commandbuffers-lifecycle recording state>
--     when 'destroyPipelineLayout' is called
--
-- == Valid Usage (Implicit)
--
-- -   @device@ /must/ be a valid 'Vulkan.Core10.Handles.Device' handle
--
-- -   If @pipelineLayout@ is not 'Vulkan.Core10.APIConstants.NULL_HANDLE',
--     @pipelineLayout@ /must/ be a valid
--     'Vulkan.Core10.Handles.PipelineLayout' handle
--
-- -   If @pAllocator@ is not @NULL@, @pAllocator@ /must/ be a valid
--     pointer to a valid
--     'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks' structure
--
-- -   If @pipelineLayout@ is a valid handle, it /must/ have been created,
--     allocated, or retrieved from @device@
--
-- == Host Synchronization
--
-- -   Host access to @pipelineLayout@ /must/ be externally synchronized
--
-- = See Also
--
-- 'Vulkan.Core10.AllocationCallbacks.AllocationCallbacks',
-- 'Vulkan.Core10.Handles.Device', 'Vulkan.Core10.Handles.PipelineLayout'
destroyPipelineLayout :: forall io
                       . (MonadIO io)
                      => -- | @device@ is the logical device that destroys the pipeline layout.
                         Device
                      -> -- | @pipelineLayout@ is the pipeline layout to destroy.
                         PipelineLayout
                      -> -- | @pAllocator@ controls host memory allocation as described in the
                         -- <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#memory-allocation Memory Allocation>
                         -- chapter.
                         ("allocator" ::: Maybe AllocationCallbacks)
                      -> io ()
destroyPipelineLayout device pipelineLayout allocator = liftIO . evalContT $ do
  let vkDestroyPipelineLayoutPtr = pVkDestroyPipelineLayout (deviceCmds (device :: Device))
  lift $ unless (vkDestroyPipelineLayoutPtr /= nullFunPtr) $
    throwIO $ IOError Nothing InvalidArgument "" "The function pointer for vkDestroyPipelineLayout is null" Nothing Nothing
  let vkDestroyPipelineLayout' = mkVkDestroyPipelineLayout vkDestroyPipelineLayoutPtr
  pAllocator <- case (allocator) of
    Nothing -> pure nullPtr
    Just j -> ContT $ withCStruct (j)
  lift $ vkDestroyPipelineLayout' (deviceHandle (device)) (pipelineLayout) pAllocator
  pure $ ()


-- | VkPushConstantRange - Structure specifying a push constant range
--
-- == Valid Usage (Implicit)
--
-- = See Also
--
-- 'PipelineLayoutCreateInfo',
-- 'Vulkan.Core10.Enums.ShaderStageFlagBits.ShaderStageFlags'
data PushConstantRange = PushConstantRange
  { -- | @stageFlags@ is a set of stage flags describing the shader stages that
    -- will access a range of push constants. If a particular stage is not
    -- included in the range, then accessing members of that range of push
    -- constants from the corresponding shader stage will return undefined
    -- values.
    --
    -- @stageFlags@ /must/ be a valid combination of
    -- 'Vulkan.Core10.Enums.ShaderStageFlagBits.ShaderStageFlagBits' values
    --
    -- @stageFlags@ /must/ not be @0@
    stageFlags :: ShaderStageFlags
  , -- | @offset@ and @size@ are the start offset and size, respectively,
    -- consumed by the range. Both @offset@ and @size@ are in units of bytes
    -- and /must/ be a multiple of 4. The layout of the push constant variables
    -- is specified in the shader.
    --
    -- @offset@ /must/ be less than
    -- 'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPushConstantsSize@
    --
    -- @offset@ /must/ be a multiple of @4@
    offset :: Word32
  , -- | @size@ /must/ be greater than @0@
    --
    -- @size@ /must/ be a multiple of @4@
    --
    -- @size@ /must/ be less than or equal to
    -- 'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPushConstantsSize@
    -- minus @offset@
    size :: Word32
  }
  deriving (Typeable, Eq)
#if defined(GENERIC_INSTANCES)
deriving instance Generic (PushConstantRange)
#endif
deriving instance Show PushConstantRange

instance ToCStruct PushConstantRange where
  withCStruct x f = allocaBytesAligned 12 4 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p PushConstantRange{..} f = do
    poke ((p `plusPtr` 0 :: Ptr ShaderStageFlags)) (stageFlags)
    poke ((p `plusPtr` 4 :: Ptr Word32)) (offset)
    poke ((p `plusPtr` 8 :: Ptr Word32)) (size)
    f
  cStructSize = 12
  cStructAlignment = 4
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr ShaderStageFlags)) (zero)
    poke ((p `plusPtr` 4 :: Ptr Word32)) (zero)
    poke ((p `plusPtr` 8 :: Ptr Word32)) (zero)
    f

instance FromCStruct PushConstantRange where
  peekCStruct p = do
    stageFlags <- peek @ShaderStageFlags ((p `plusPtr` 0 :: Ptr ShaderStageFlags))
    offset <- peek @Word32 ((p `plusPtr` 4 :: Ptr Word32))
    size <- peek @Word32 ((p `plusPtr` 8 :: Ptr Word32))
    pure $ PushConstantRange
             stageFlags offset size

instance Storable PushConstantRange where
  sizeOf ~_ = 12
  alignment ~_ = 4
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero PushConstantRange where
  zero = PushConstantRange
           zero
           zero
           zero


-- | VkPipelineLayoutCreateInfo - Structure specifying the parameters of a
-- newly created pipeline layout object
--
-- == Valid Usage
--
-- -   @setLayoutCount@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxBoundDescriptorSets@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLER' and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorSamplers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER'
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorUniformBuffers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER'
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorStorageBuffers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER',
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLED_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorSampledImages@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorStorageImages@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INPUT_ATTACHMENT'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxPerStageDescriptorInputAttachments@
--
-- -   The total number of bindings in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INLINE_UNIFORM_BLOCK_EXT'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Extensions.VK_EXT_inline_uniform_block.PhysicalDeviceInlineUniformBlockPropertiesEXT'::@maxPerStageDescriptorInlineUniformBlocks@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLER' and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindSamplers@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER'
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindUniformBuffers@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER'
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindStorageBuffers@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER',
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLED_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindSampledImages@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindStorageImages@
--
-- -   The total number of descriptors with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INPUT_ATTACHMENT'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxPerStageDescriptorUpdateAfterBindInputAttachments@
--
-- -   The total number of bindings with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INLINE_UNIFORM_BLOCK_EXT'
--     accessible to any given shader stage across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Extensions.VK_EXT_inline_uniform_block.PhysicalDeviceInlineUniformBlockPropertiesEXT'::@maxPerStageDescriptorUpdateAfterBindInlineUniformBlocks@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLER' and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetSamplers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetUniformBuffers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetUniformBuffersDynamic@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetStorageBuffers@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetStorageBuffersDynamic@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER',
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLED_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetSampledImages@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetStorageImages@
--
-- -   The total number of descriptors in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INPUT_ATTACHMENT'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core10.DeviceInitialization.PhysicalDeviceLimits'::@maxDescriptorSetInputAttachments@
--
-- -   The total number of bindings in descriptor set layouts created
--     without the
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT'
--     bit set with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INLINE_UNIFORM_BLOCK_EXT'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Extensions.VK_EXT_inline_uniform_block.PhysicalDeviceInlineUniformBlockPropertiesEXT'::@maxDescriptorSetInlineUniformBlocks@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLER' and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindSamplers@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindUniformBuffers@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindUniformBuffersDynamic@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindStorageBuffers@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindStorageBuffersDynamic@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER',
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_SAMPLED_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindSampledImages@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_IMAGE',
--     and
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindStorageImages@
--
-- -   The total number of descriptors of the type
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INPUT_ATTACHMENT'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing.PhysicalDeviceDescriptorIndexingProperties'::@maxDescriptorSetUpdateAfterBindInputAttachments@
--
-- -   The total number of bindings with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_INLINE_UNIFORM_BLOCK_EXT'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Extensions.VK_EXT_inline_uniform_block.PhysicalDeviceInlineUniformBlockPropertiesEXT'::@maxDescriptorSetUpdateAfterBindInlineUniformBlocks@
--
-- -   Any two elements of @pPushConstantRanges@ /must/ not include the
--     same stage in @stageFlags@
--
-- -   @pSetLayouts@ /must/ not contain more than one descriptor set layout
--     that was created with
--     'Vulkan.Core10.Enums.DescriptorSetLayoutCreateFlagBits.DESCRIPTOR_SET_LAYOUT_CREATE_PUSH_DESCRIPTOR_BIT_KHR'
--     set
--
-- -   The total number of bindings with a @descriptorType@ of
--     'Vulkan.Core10.Enums.DescriptorType.DESCRIPTOR_TYPE_ACCELERATION_STRUCTURE_KHR'
--     accessible across all shader stages and across all elements of
--     @pSetLayouts@ /must/ be less than or equal to
--     'Vulkan.Extensions.VK_KHR_ray_tracing.PhysicalDeviceRayTracingPropertiesKHR'::@maxDescriptorSetAccelerationStructures@
--
-- -   The total number of @pImmutableSamplers@ created with @flags@
--     containing
--     'Vulkan.Core10.Enums.SamplerCreateFlagBits.SAMPLER_CREATE_SUBSAMPLED_BIT_EXT'
--     or
--     'Vulkan.Core10.Enums.SamplerCreateFlagBits.SAMPLER_CREATE_SUBSAMPLED_COARSE_RECONSTRUCTION_BIT_EXT'
--     across all shader stages and across all elements of @pSetLayouts@
--     /must/ be less than or equal to
--     <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#limits-maxDescriptorSetSubsampledSamplers ::maxDescriptorSetSubsampledSamplers>
--
-- == Valid Usage (Implicit)
--
-- -   @sType@ /must/ be
--     'Vulkan.Core10.Enums.StructureType.STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO'
--
-- -   @pNext@ /must/ be @NULL@
--
-- -   @flags@ /must/ be @0@
--
-- -   If @setLayoutCount@ is not @0@, @pSetLayouts@ /must/ be a valid
--     pointer to an array of @setLayoutCount@ valid
--     'Vulkan.Core10.Handles.DescriptorSetLayout' handles
--
-- -   If @pushConstantRangeCount@ is not @0@, @pPushConstantRanges@ /must/
--     be a valid pointer to an array of @pushConstantRangeCount@ valid
--     'PushConstantRange' structures
--
-- = See Also
--
-- 'Vulkan.Core10.Handles.DescriptorSetLayout',
-- 'Vulkan.Core10.Enums.PipelineLayoutCreateFlags.PipelineLayoutCreateFlags',
-- 'PushConstantRange', 'Vulkan.Core10.Enums.StructureType.StructureType',
-- 'createPipelineLayout'
data PipelineLayoutCreateInfo = PipelineLayoutCreateInfo
  { -- | @flags@ is reserved for future use.
    flags :: PipelineLayoutCreateFlags
  , -- | @pSetLayouts@ is a pointer to an array of
    -- 'Vulkan.Core10.Handles.DescriptorSetLayout' objects.
    setLayouts :: Vector DescriptorSetLayout
  , -- | @pPushConstantRanges@ is a pointer to an array of 'PushConstantRange'
    -- structures defining a set of push constant ranges for use in a single
    -- pipeline layout. In addition to descriptor set layouts, a pipeline
    -- layout also describes how many push constants /can/ be accessed by each
    -- stage of the pipeline.
    --
    -- Note
    --
    -- Push constants represent a high speed path to modify constant data in
    -- pipelines that is expected to outperform memory-backed resource updates.
    pushConstantRanges :: Vector PushConstantRange
  }
  deriving (Typeable)
#if defined(GENERIC_INSTANCES)
deriving instance Generic (PipelineLayoutCreateInfo)
#endif
deriving instance Show PipelineLayoutCreateInfo

instance ToCStruct PipelineLayoutCreateInfo where
  withCStruct x f = allocaBytesAligned 48 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p PipelineLayoutCreateInfo{..} f = evalContT $ do
    lift $ poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO)
    lift $ poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    lift $ poke ((p `plusPtr` 16 :: Ptr PipelineLayoutCreateFlags)) (flags)
    lift $ poke ((p `plusPtr` 20 :: Ptr Word32)) ((fromIntegral (Data.Vector.length $ (setLayouts)) :: Word32))
    pPSetLayouts' <- ContT $ allocaBytesAligned @DescriptorSetLayout ((Data.Vector.length (setLayouts)) * 8) 8
    lift $ Data.Vector.imapM_ (\i e -> poke (pPSetLayouts' `plusPtr` (8 * (i)) :: Ptr DescriptorSetLayout) (e)) (setLayouts)
    lift $ poke ((p `plusPtr` 24 :: Ptr (Ptr DescriptorSetLayout))) (pPSetLayouts')
    lift $ poke ((p `plusPtr` 32 :: Ptr Word32)) ((fromIntegral (Data.Vector.length $ (pushConstantRanges)) :: Word32))
    pPPushConstantRanges' <- ContT $ allocaBytesAligned @PushConstantRange ((Data.Vector.length (pushConstantRanges)) * 12) 4
    Data.Vector.imapM_ (\i e -> ContT $ pokeCStruct (pPPushConstantRanges' `plusPtr` (12 * (i)) :: Ptr PushConstantRange) (e) . ($ ())) (pushConstantRanges)
    lift $ poke ((p `plusPtr` 40 :: Ptr (Ptr PushConstantRange))) (pPPushConstantRanges')
    lift $ f
  cStructSize = 48
  cStructAlignment = 8
  pokeZeroCStruct p f = evalContT $ do
    lift $ poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO)
    lift $ poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    pPSetLayouts' <- ContT $ allocaBytesAligned @DescriptorSetLayout ((Data.Vector.length (mempty)) * 8) 8
    lift $ Data.Vector.imapM_ (\i e -> poke (pPSetLayouts' `plusPtr` (8 * (i)) :: Ptr DescriptorSetLayout) (e)) (mempty)
    lift $ poke ((p `plusPtr` 24 :: Ptr (Ptr DescriptorSetLayout))) (pPSetLayouts')
    pPPushConstantRanges' <- ContT $ allocaBytesAligned @PushConstantRange ((Data.Vector.length (mempty)) * 12) 4
    Data.Vector.imapM_ (\i e -> ContT $ pokeCStruct (pPPushConstantRanges' `plusPtr` (12 * (i)) :: Ptr PushConstantRange) (e) . ($ ())) (mempty)
    lift $ poke ((p `plusPtr` 40 :: Ptr (Ptr PushConstantRange))) (pPPushConstantRanges')
    lift $ f

instance FromCStruct PipelineLayoutCreateInfo where
  peekCStruct p = do
    flags <- peek @PipelineLayoutCreateFlags ((p `plusPtr` 16 :: Ptr PipelineLayoutCreateFlags))
    setLayoutCount <- peek @Word32 ((p `plusPtr` 20 :: Ptr Word32))
    pSetLayouts <- peek @(Ptr DescriptorSetLayout) ((p `plusPtr` 24 :: Ptr (Ptr DescriptorSetLayout)))
    pSetLayouts' <- generateM (fromIntegral setLayoutCount) (\i -> peek @DescriptorSetLayout ((pSetLayouts `advancePtrBytes` (8 * (i)) :: Ptr DescriptorSetLayout)))
    pushConstantRangeCount <- peek @Word32 ((p `plusPtr` 32 :: Ptr Word32))
    pPushConstantRanges <- peek @(Ptr PushConstantRange) ((p `plusPtr` 40 :: Ptr (Ptr PushConstantRange)))
    pPushConstantRanges' <- generateM (fromIntegral pushConstantRangeCount) (\i -> peekCStruct @PushConstantRange ((pPushConstantRanges `advancePtrBytes` (12 * (i)) :: Ptr PushConstantRange)))
    pure $ PipelineLayoutCreateInfo
             flags pSetLayouts' pPushConstantRanges'

instance Zero PipelineLayoutCreateInfo where
  zero = PipelineLayoutCreateInfo
           zero
           mempty
           mempty

