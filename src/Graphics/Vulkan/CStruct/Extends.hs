{-# language CPP #-}
module Graphics.Vulkan.CStruct.Extends  ( BaseOutStructure(..)
                                        , BaseInStructure(..)
                                        , Extends
                                        , PeekChain(..)
                                        , PokeChain(..)
                                        , Chain
                                        , Extendss
                                        , SomeStruct(..)
                                        , withSomeCStruct
                                        , peekSomeCStruct
                                        , pokeSomeCStruct
                                        , forgetExtensions
                                        , Extensible(..)
                                        , pattern (::&)
                                        , pattern (:&)
                                        ) where

import Data.Maybe (fromMaybe)
import Type.Reflection (typeRep)
import Foreign.Marshal.Alloc (allocaBytesAligned)
import GHC.Base (join)
import GHC.IO (throwIO)
import GHC.Ptr (castPtr)
import Foreign.Ptr (nullPtr)
import Foreign.Ptr (plusPtr)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Cont (evalContT)
import Data.Proxy (Proxy(Proxy))
import Data.Typeable (Typeable)
import Foreign.Storable (Storable)
import Foreign.Storable (Storable(peek))
import Foreign.Storable (Storable(poke))
import qualified Foreign.Storable (Storable(..))
import GHC.IO.Exception (IOErrorType(..))
import GHC.IO.Exception (IOException(..))
import Foreign.Ptr (Ptr)
import GHC.TypeLits (ErrorMessage(..))
import GHC.TypeLits (TypeError)
import Data.Kind (Constraint)
import Data.Kind (Type)
import Control.Monad.Trans.Cont (ContT(..))
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AabbPositionsKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureBuildGeometryInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureBuildOffsetInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureCreateGeometryTypeInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (AccelerationStructureCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureDeviceAddressInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureGeometryAabbsDataKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureGeometryInstancesDataKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureGeometryKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureGeometryTrianglesDataKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (AccelerationStructureInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureInstanceKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureMemoryRequirementsInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (AccelerationStructureMemoryRequirementsInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (AccelerationStructureVersionKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (AcquireNextImageInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (AcquireProfilingLockInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.AllocationCallbacks (AllocationCallbacks)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (AndroidHardwareBufferFormatPropertiesANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (AndroidHardwareBufferPropertiesANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (AndroidHardwareBufferUsageANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_android_surface (AndroidSurfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (ApplicationInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (AttachmentDescription)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (AttachmentDescription2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_separate_depth_stencil_layouts (AttachmentDescriptionStencilLayout)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (AttachmentReference)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (AttachmentReference2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_separate_depth_stencil_layouts (AttachmentReferenceStencilLayout)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (AttachmentSampleLocationsEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (BindAccelerationStructureMemoryInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_groupAndVK_KHR_bind_memory2 (BindBufferMemoryDeviceGroupInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_bind_memory2 (BindBufferMemoryInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_groupAndVK_KHR_bind_memory2 (BindImageMemoryDeviceGroupInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_bind_memory2 (BindImageMemoryInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (BindImageMemorySwapchainInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (BindImagePlaneMemoryInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (BindIndexBufferIndirectCommandNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (BindShaderGroupIndirectCommandNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (BindSparseInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (BindVertexBufferIndirectCommandNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (BufferCopy)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Buffer (BufferCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_buffer_device_address (BufferDeviceAddressCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_buffer_device_address (BufferDeviceAddressInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (BufferImageCopy)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (BufferMemoryBarrier)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_memory_requirements2 (BufferMemoryRequirementsInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_buffer_device_address (BufferOpaqueCaptureAddressCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.BufferView (BufferViewCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_calibrated_timestamps (CalibratedTimestampInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_diagnostic_checkpoints (CheckpointDataNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (ClearAttachment)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (ClearDepthStencilValue)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (ClearRect)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (CoarseSampleLocationNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (CoarseSampleOrderCustomNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBuffer (CommandBufferAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBuffer (CommandBufferBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_conditional_rendering (CommandBufferInheritanceConditionalRenderingInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBuffer (CommandBufferInheritanceInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_QCOM_render_pass_transform (CommandBufferInheritanceRenderPassTransformInfoQCOM)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandPool (CommandPoolCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.ImageView (ComponentMapping)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (ComputePipelineCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_conditional_rendering (ConditionalRenderingBeginInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_driver_properties (ConformanceVersion)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_cooperative_matrix (CooperativeMatrixPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (CopyAccelerationStructureInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (CopyAccelerationStructureToMemoryInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (CopyDescriptorSet)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (CopyMemoryToAccelerationStructureInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32 (D3D12FenceSubmitInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_marker (DebugMarkerMarkerInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_marker (DebugMarkerObjectNameInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_marker (DebugMarkerObjectTagInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_report (DebugReportCallbackCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_utils (DebugUtilsLabelEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_utils (DebugUtilsMessengerCallbackDataEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_utils (DebugUtilsMessengerCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_utils (DebugUtilsObjectNameInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_debug_utils (DebugUtilsObjectTagInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_dedicated_allocation (DedicatedAllocationBufferCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_dedicated_allocation (DedicatedAllocationImageCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_dedicated_allocation (DedicatedAllocationMemoryAllocateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_deferred_host_operations (DeferredOperationInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorBufferInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorImageInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorPoolCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_inline_uniform_block (DescriptorPoolInlineUniformBlockCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorPoolSize)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorSetAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorSetLayoutBinding)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing (DescriptorSetLayoutBindingFlagsCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (DescriptorSetLayoutCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance3 (DescriptorSetLayoutSupport)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing (DescriptorSetVariableDescriptorCountAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing (DescriptorSetVariableDescriptorCountLayoutSupport)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_descriptor_update_template (DescriptorUpdateTemplateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_descriptor_update_template (DescriptorUpdateTemplateEntry)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Device (DeviceCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_diagnostics_config (DeviceDiagnosticsConfigCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_display_control (DeviceEventInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group (DeviceGroupBindSparseInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group (DeviceGroupCommandBufferBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group_creation (DeviceGroupDeviceCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (DeviceGroupPresentCapabilitiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (DeviceGroupPresentInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group (DeviceGroupRenderPassBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group (DeviceGroupSubmitInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (DeviceGroupSwapchainCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_buffer_device_address (DeviceMemoryOpaqueCaptureAddressInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_memory_overallocation_behavior (DeviceMemoryOverallocationCreateInfoAMD)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Device (DeviceQueueCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_global_priority (DeviceQueueGlobalPriorityCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Originally_Based_On_VK_KHR_protected_memory (DeviceQueueInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (DispatchIndirectCommand)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_display_control (DisplayEventInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayModeCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayModeParametersKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_display_properties2 (DisplayModeProperties2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayModePropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_display_native_hdr (DisplayNativeHdrSurfaceCapabilitiesAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_display_properties2 (DisplayPlaneCapabilities2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayPlaneCapabilitiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_display_properties2 (DisplayPlaneInfo2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_display_properties2 (DisplayPlaneProperties2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayPlanePropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_display_control (DisplayPowerInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display_swapchain (DisplayPresentInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_display_properties2 (DisplayProperties2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplayPropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_display (DisplaySurfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (DrawIndexedIndirectCommand)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (DrawIndirectCommand)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_mesh_shader (DrawMeshTasksIndirectCommandNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (DrmFormatModifierPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (DrmFormatModifierPropertiesListEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Event (EventCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_fence (ExportFenceCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_fence_win32 (ExportFenceWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory (ExportMemoryAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_external_memory (ExportMemoryAllocateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_win32 (ExportMemoryWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_external_memory_win32 (ExportMemoryWin32HandleInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_semaphore (ExportSemaphoreCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32 (ExportSemaphoreWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.ExtensionDiscovery (ExtensionProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (Extent2D)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (Extent3D)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (ExternalBufferProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_fence_capabilities (ExternalFenceProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (ExternalFormatANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (ExternalImageFormatProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_external_memory_capabilities (ExternalImageFormatPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory (ExternalMemoryBufferCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory (ExternalMemoryImageCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_external_memory (ExternalMemoryImageCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (ExternalMemoryProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_semaphore_capabilities (ExternalSemaphoreProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Fence (FenceCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_fence_fd (FenceGetFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_fence_win32 (FenceGetWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_filter_cubic (FilterCubicImageViewImageFormatPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (FormatProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (FormatProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_imageless_framebuffer (FramebufferAttachmentImageInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_imageless_framebuffer (FramebufferAttachmentsCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (FramebufferCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_coverage_reduction_mode (FramebufferMixedSamplesCombinationNV)
import Graphics.Vulkan.CStruct (FromCStruct)
import Graphics.Vulkan.CStruct (FromCStruct(..))
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (GeneratedCommandsInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (GeneratedCommandsMemoryRequirementsInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (GeometryAABBNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (GeometryDataNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (GeometryNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (GeometryTrianglesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (GraphicsPipelineCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (GraphicsPipelineShaderGroupsCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (GraphicsShaderGroupCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_hdr_metadata (HdrMetadataEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_headless_surface (HeadlessSurfaceCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_MVK_ios_surface (IOSSurfaceCreateInfoMVK)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (ImageBlit)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (ImageCopy)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Image (ImageCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (ImageDrmFormatModifierExplicitCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (ImageDrmFormatModifierListCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (ImageDrmFormatModifierPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_image_format_list (ImageFormatListCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (ImageFormatProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (ImageFormatProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (ImageMemoryBarrier)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_memory_requirements2 (ImageMemoryRequirementsInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_FUCHSIA_imagepipe_surface (ImagePipeSurfaceCreateInfoFUCHSIA)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (ImagePlaneMemoryRequirementsInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (ImageResolve)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_memory_requirements2 (ImageSparseMemoryRequirementsInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_separate_stencil_usage (ImageStencilUsageCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Image (ImageSubresource)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (ImageSubresourceLayers)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (ImageSubresourceRange)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (ImageSwapchainCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_astc_decode_mode (ImageViewASTCDecodeModeEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.ImageView (ImageViewCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NVX_image_view_handle (ImageViewHandleInfoNVX)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance2 (ImageViewUsageCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (ImportAndroidHardwareBufferInfoANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_fence_fd (ImportFenceFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_fence_win32 (ImportFenceWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_fd (ImportMemoryFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_external_memory_host (ImportMemoryHostPointerInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_win32 (ImportMemoryWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_external_memory_win32 (ImportMemoryWin32HandleInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_fd (ImportSemaphoreFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32 (ImportSemaphoreWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (IndirectCommandsLayoutCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (IndirectCommandsLayoutTokenNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (IndirectCommandsStreamNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (InitializePerformanceApiInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance2 (InputAttachmentAspectReference)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (InstanceCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.LayerDiscovery (LayerProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_MVK_macos_surface (MacOSSurfaceCreateInfoMVK)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Memory (MappedMemoryRange)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group (MemoryAllocateFlagsInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Memory (MemoryAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.OtherTypes (MemoryBarrier)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_dedicated_allocation (MemoryDedicatedAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_dedicated_allocation (MemoryDedicatedRequirements)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_fd (MemoryFdPropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_ANDROID_external_memory_android_hardware_buffer (MemoryGetAndroidHardwareBufferInfoANDROID)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_fd (MemoryGetFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_win32 (MemoryGetWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (MemoryHeap)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_external_memory_host (MemoryHostPointerPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_buffer_device_address (MemoryOpaqueCaptureAddressAllocateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_memory_priority (MemoryPriorityAllocateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.MemoryManagement (MemoryRequirements)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_memory_requirements2 (MemoryRequirements2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (MemoryType)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_memory_win32 (MemoryWin32HandlePropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_metal_surface (MetalSurfaceCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (MultisamplePropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (Offset2D)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SharedTypes (Offset3D)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GOOGLE_display_timing (PastPresentationTimingGOOGLE)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (PerformanceConfigurationAcquireInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (PerformanceCounterDescriptionKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (PerformanceCounterKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (PerformanceMarkerInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (PerformanceOverrideInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (PerformanceQuerySubmitInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (PerformanceStreamMarkerInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (PerformanceValueINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_16bit_storage (PhysicalDevice16BitStorageFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_8bit_storage (PhysicalDevice8BitStorageFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_astc_decode_mode (PhysicalDeviceASTCDecodeFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_blend_operation_advanced (PhysicalDeviceBlendOperationAdvancedFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_blend_operation_advanced (PhysicalDeviceBlendOperationAdvancedPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_buffer_device_address (PhysicalDeviceBufferDeviceAddressFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_buffer_device_address (PhysicalDeviceBufferDeviceAddressFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_device_coherent_memory (PhysicalDeviceCoherentMemoryFeaturesAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_compute_shader_derivatives (PhysicalDeviceComputeShaderDerivativesFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_conditional_rendering (PhysicalDeviceConditionalRenderingFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_conservative_rasterization (PhysicalDeviceConservativeRasterizationPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_cooperative_matrix (PhysicalDeviceCooperativeMatrixFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_cooperative_matrix (PhysicalDeviceCooperativeMatrixPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_corner_sampled_image (PhysicalDeviceCornerSampledImageFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_coverage_reduction_mode (PhysicalDeviceCoverageReductionModeFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_dedicated_allocation_image_aliasing (PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_depth_clip_enable (PhysicalDeviceDepthClipEnableFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_depth_stencil_resolve (PhysicalDeviceDepthStencilResolveProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing (PhysicalDeviceDescriptorIndexingFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_descriptor_indexing (PhysicalDeviceDescriptorIndexingProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (PhysicalDeviceDeviceGeneratedCommandsFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (PhysicalDeviceDeviceGeneratedCommandsPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_diagnostics_config (PhysicalDeviceDiagnosticsConfigFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_discard_rectangles (PhysicalDeviceDiscardRectanglePropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_driver_properties (PhysicalDeviceDriverProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_scissor_exclusive (PhysicalDeviceExclusiveScissorFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (PhysicalDeviceExternalBufferInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_fence_capabilities (PhysicalDeviceExternalFenceInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (PhysicalDeviceExternalImageFormatInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_external_memory_host (PhysicalDeviceExternalMemoryHostPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_semaphore_capabilities (PhysicalDeviceExternalSemaphoreInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (PhysicalDeviceFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (PhysicalDeviceFeatures2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_shader_float_controls (PhysicalDeviceFloatControlsProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_fragment_density_map (PhysicalDeviceFragmentDensityMapFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_fragment_density_map (PhysicalDeviceFragmentDensityMapPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_fragment_shader_barycentric (PhysicalDeviceFragmentShaderBarycentricFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_fragment_shader_interlock (PhysicalDeviceFragmentShaderInterlockFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_device_group_creation (PhysicalDeviceGroupProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_host_query_reset (PhysicalDeviceHostQueryResetFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities (PhysicalDeviceIDProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_image_drm_format_modifier (PhysicalDeviceImageDrmFormatModifierInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (PhysicalDeviceImageFormatInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_filter_cubic (PhysicalDeviceImageViewImageFormatInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_imageless_framebuffer (PhysicalDeviceImagelessFramebufferFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_index_type_uint8 (PhysicalDeviceIndexTypeUint8FeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_inline_uniform_block (PhysicalDeviceInlineUniformBlockFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_inline_uniform_block (PhysicalDeviceInlineUniformBlockPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (PhysicalDeviceLimits)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_line_rasterization (PhysicalDeviceLineRasterizationFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_line_rasterization (PhysicalDeviceLineRasterizationPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance3 (PhysicalDeviceMaintenance3Properties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_memory_budget (PhysicalDeviceMemoryBudgetPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_memory_priority (PhysicalDeviceMemoryPriorityFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (PhysicalDeviceMemoryProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (PhysicalDeviceMemoryProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_mesh_shader (PhysicalDeviceMeshShaderFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_mesh_shader (PhysicalDeviceMeshShaderPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_multiview (PhysicalDeviceMultiviewFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NVX_multiview_per_view_attributes (PhysicalDeviceMultiviewPerViewAttributesPropertiesNVX)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_multiview (PhysicalDeviceMultiviewProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_pci_bus_info (PhysicalDevicePCIBusInfoPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (PhysicalDevicePerformanceQueryFeaturesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (PhysicalDevicePerformanceQueryPropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_pipeline_creation_cache_control (PhysicalDevicePipelineCreationCacheControlFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PhysicalDevicePipelineExecutablePropertiesFeaturesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance2 (PhysicalDevicePointClippingProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (PhysicalDeviceProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (PhysicalDeviceProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Originally_Based_On_VK_KHR_protected_memory (PhysicalDeviceProtectedMemoryFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Originally_Based_On_VK_KHR_protected_memory (PhysicalDeviceProtectedMemoryProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_push_descriptor (PhysicalDevicePushDescriptorPropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (PhysicalDeviceRayTracingFeaturesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (PhysicalDeviceRayTracingPropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (PhysicalDeviceRayTracingPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_representative_fragment_test (PhysicalDeviceRepresentativeFragmentTestFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (PhysicalDeviceSampleLocationsPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_sampler_filter_minmax (PhysicalDeviceSamplerFilterMinmaxProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (PhysicalDeviceSamplerYcbcrConversionFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_scalar_block_layout (PhysicalDeviceScalarBlockLayoutFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_separate_depth_stencil_layouts (PhysicalDeviceSeparateDepthStencilLayoutsFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_shader_atomic_int64 (PhysicalDeviceShaderAtomicInt64Features)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_shader_clock (PhysicalDeviceShaderClockFeaturesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_shader_core_properties2 (PhysicalDeviceShaderCoreProperties2AMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_shader_core_properties (PhysicalDeviceShaderCorePropertiesAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_shader_demote_to_helper_invocation (PhysicalDeviceShaderDemoteToHelperInvocationFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_shader_draw_parameters (PhysicalDeviceShaderDrawParametersFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_shader_float16_int8 (PhysicalDeviceShaderFloat16Int8Features)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shader_image_footprint (PhysicalDeviceShaderImageFootprintFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_shader_integer_functions2 (PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shader_sm_builtins (PhysicalDeviceShaderSMBuiltinsFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shader_sm_builtins (PhysicalDeviceShaderSMBuiltinsPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_shader_subgroup_extended_types (PhysicalDeviceShaderSubgroupExtendedTypesFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (PhysicalDeviceShadingRateImageFeaturesNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (PhysicalDeviceShadingRateImagePropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (PhysicalDeviceSparseImageFormatInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (PhysicalDeviceSparseProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Originally_Based_On_VK_KHR_subgroup (PhysicalDeviceSubgroupProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_subgroup_size_control (PhysicalDeviceSubgroupSizeControlFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_subgroup_size_control (PhysicalDeviceSubgroupSizeControlPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_surface_capabilities2 (PhysicalDeviceSurfaceInfo2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_texel_buffer_alignment (PhysicalDeviceTexelBufferAlignmentFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_texel_buffer_alignment (PhysicalDeviceTexelBufferAlignmentPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_texture_compression_astc_hdr (PhysicalDeviceTextureCompressionASTCHDRFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (PhysicalDeviceTimelineSemaphoreFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (PhysicalDeviceTimelineSemaphoreProperties)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_tooling_info (PhysicalDeviceToolPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_transform_feedback (PhysicalDeviceTransformFeedbackFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_transform_feedback (PhysicalDeviceTransformFeedbackPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_uniform_buffer_standard_layout (PhysicalDeviceUniformBufferStandardLayoutFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_variable_pointers (PhysicalDeviceVariablePointersFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_vertex_attribute_divisor (PhysicalDeviceVertexAttributeDivisorFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_vertex_attribute_divisor (PhysicalDeviceVertexAttributeDivisorPropertiesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core12 (PhysicalDeviceVulkan11Features)
import {-# SOURCE #-} Graphics.Vulkan.Core12 (PhysicalDeviceVulkan11Properties)
import {-# SOURCE #-} Graphics.Vulkan.Core12 (PhysicalDeviceVulkan12Features)
import {-# SOURCE #-} Graphics.Vulkan.Core12 (PhysicalDeviceVulkan12Properties)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_vulkan_memory_model (PhysicalDeviceVulkanMemoryModelFeatures)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_ycbcr_image_arrays (PhysicalDeviceYcbcrImageArraysFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.PipelineCache (PipelineCacheCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_blend_operation_advanced (PipelineColorBlendAdvancedStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineColorBlendAttachmentState)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineColorBlendStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_pipeline_compiler_control (PipelineCompilerControlCreateInfoAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_framebuffer_mixed_samples (PipelineCoverageModulationStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_coverage_reduction_mode (PipelineCoverageReductionStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_fragment_coverage_to_color (PipelineCoverageToColorStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_pipeline_creation_feedback (PipelineCreationFeedbackCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_pipeline_creation_feedback (PipelineCreationFeedbackEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineDepthStencilStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_discard_rectangles (PipelineDiscardRectangleStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineDynamicStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PipelineExecutableInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PipelineExecutableInternalRepresentationKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PipelineExecutablePropertiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PipelineExecutableStatisticKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_executable_properties (PipelineInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineInputAssemblyStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.PipelineLayout (PipelineLayoutCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_pipeline_library (PipelineLibraryCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineMultisampleStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_conservative_rasterization (PipelineRasterizationConservativeStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_depth_clip_enable (PipelineRasterizationDepthClipStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_line_rasterization (PipelineRasterizationLineStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineRasterizationStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_rasterization_order (PipelineRasterizationStateRasterizationOrderAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_transform_feedback (PipelineRasterizationStateStreamCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_representative_fragment_test (PipelineRepresentativeFragmentTestStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (PipelineSampleLocationsStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineShaderStageCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_subgroup_size_control (PipelineShaderStageRequiredSubgroupSizeCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance2 (PipelineTessellationDomainOriginStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineTessellationStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_vertex_attribute_divisor (PipelineVertexInputDivisorStateCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineVertexInputStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (PipelineViewportCoarseSampleOrderStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_scissor_exclusive (PipelineViewportExclusiveScissorStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (PipelineViewportShadingRateImageStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (PipelineViewportStateCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_viewport_swizzle (PipelineViewportSwizzleStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_clip_space_w_scaling (PipelineViewportWScalingStateCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GGP_frame_token (PresentFrameTokenGGP)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (PresentInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_incremental_present (PresentRegionKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_incremental_present (PresentRegionsKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GOOGLE_display_timing (PresentTimeGOOGLE)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GOOGLE_display_timing (PresentTimesInfoGOOGLE)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Originally_Based_On_VK_KHR_protected_memory (ProtectedSubmitInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.PipelineLayout (PushConstantRange)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Query (QueryPoolCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_performance_query (QueryPoolPerformanceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_INTEL_performance_query (QueryPoolPerformanceQueryCreateInfoINTEL)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_diagnostic_checkpoints (QueueFamilyCheckpointPropertiesNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DeviceInitialization (QueueFamilyProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (QueueFamilyProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (RayTracingPipelineCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (RayTracingPipelineCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (RayTracingPipelineInterfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (RayTracingShaderGroupCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_ray_tracing (RayTracingShaderGroupCreateInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (Rect2D)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_incremental_present (RectLayerKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GOOGLE_display_timing (RefreshCycleDurationGOOGLE)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_imageless_framebuffer (RenderPassAttachmentBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (RenderPassBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (RenderPassCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (RenderPassCreateInfo2)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_fragment_density_map (RenderPassFragmentDensityMapCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_maintenance2 (RenderPassInputAttachmentAspectCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_multiview (RenderPassMultiviewCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (RenderPassSampleLocationsBeginInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_QCOM_render_pass_transform (RenderPassTransformBeginInfoQCOM)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (SampleLocationEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (SampleLocationsInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Sampler (SamplerCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_EXT_sampler_filter_minmax (SamplerReductionModeCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (SamplerYcbcrConversionCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (SamplerYcbcrConversionImageFormatProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_sampler_ycbcr_conversion (SamplerYcbcrConversionInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.QueueSemaphore (SemaphoreCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_fd (SemaphoreGetFdInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32 (SemaphoreGetWin32HandleInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (SemaphoreSignalInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (SemaphoreTypeCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (SemaphoreWaitInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_device_generated_commands (SetStateFlagsIndirectCommandNV)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Shader (ShaderModuleCreateInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_validation_cache (ShaderModuleValidationCacheCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_shader_info (ShaderResourceUsageAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_shader_info (ShaderStatisticsInfoAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_shading_rate_image (ShadingRatePaletteNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_shared_presentable_image (SharedPresentSurfaceCapabilitiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseBufferMemoryBindInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseImageFormatProperties)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_physical_device_properties2 (SparseImageFormatProperties2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseImageMemoryBind)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseImageMemoryBindInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseImageMemoryRequirements)
import {-# SOURCE #-} Graphics.Vulkan.Core11.Promoted_From_VK_KHR_get_memory_requirements2 (SparseImageMemoryRequirements2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseImageOpaqueMemoryBindInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.SparseResourceMemoryManagement (SparseMemoryBind)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (SpecializationInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (SpecializationMapEntry)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (StencilOpState)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_GGP_stream_descriptor_surface (StreamDescriptorSurfaceCreateInfoGGP)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (StridedBufferRegionKHR)
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType)
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType(..))
import {-# SOURCE #-} Graphics.Vulkan.Core10.Queue (SubmitInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (SubpassBeginInfo)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (SubpassDependency)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (SubpassDependency2)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pass (SubpassDescription)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (SubpassDescription2)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_depth_stencil_resolve (SubpassDescriptionDepthStencilResolve)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_create_renderpass2 (SubpassEndInfo)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_sample_locations (SubpassSampleLocationsEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Image (SubresourceLayout)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_display_surface_counter (SurfaceCapabilities2EXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_surface_capabilities2 (SurfaceCapabilities2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_full_screen_exclusive (SurfaceCapabilitiesFullScreenExclusiveEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_surface (SurfaceCapabilitiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_get_surface_capabilities2 (SurfaceFormat2KHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_surface (SurfaceFormatKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_full_screen_exclusive (SurfaceFullScreenExclusiveInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_full_screen_exclusive (SurfaceFullScreenExclusiveWin32InfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_surface_protected_capabilities (SurfaceProtectedCapabilitiesKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_display_control (SwapchainCounterCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_swapchain (SwapchainCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_display_native_hdr (SwapchainDisplayNativeHdrCreateInfoAMD)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_AMD_texture_gather_bias_lod (TextureLODGatherFormatPropertiesAMD)
import {-# SOURCE #-} Graphics.Vulkan.Core12.Promoted_From_VK_KHR_timeline_semaphore (TimelineSemaphoreSubmitInfo)
import Graphics.Vulkan.CStruct (ToCStruct)
import Graphics.Vulkan.CStruct (ToCStruct(..))
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (TraceRaysIndirectCommandKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (TransformMatrixKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_validation_cache (ValidationCacheCreateInfoEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_validation_features (ValidationFeaturesEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_validation_flags (ValidationFlagsEXT)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (VertexInputAttributeDescription)
import {-# SOURCE #-} Graphics.Vulkan.Core10.Pipeline (VertexInputBindingDescription)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_vertex_attribute_divisor (VertexInputBindingDivisorDescriptionEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NN_vi_surface (ViSurfaceCreateInfoNN)
import {-# SOURCE #-} Graphics.Vulkan.Core10.CommandBufferBuilding (Viewport)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_viewport_swizzle (ViewportSwizzleNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_clip_space_w_scaling (ViewportWScalingNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_wayland_surface (WaylandSurfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_win32_keyed_mutex (Win32KeyedMutexAcquireReleaseInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_NV_win32_keyed_mutex (Win32KeyedMutexAcquireReleaseInfoNV)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_win32_surface (Win32SurfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Core10.DescriptorSet (WriteDescriptorSet)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_ray_tracing (WriteDescriptorSetAccelerationStructureKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_inline_uniform_block (WriteDescriptorSetInlineUniformBlockEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_EXT_hdr_metadata (XYColorEXT)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_xcb_surface (XcbSurfaceCreateInfoKHR)
import {-# SOURCE #-} Graphics.Vulkan.Extensions.VK_KHR_xlib_surface (XlibSurfaceCreateInfoKHR)
import Graphics.Vulkan.Zero (Zero(..))
-- | VkBaseOutStructure - Base structure for a read-only pointer chain
--
-- = Description
--
-- 'BaseOutStructure' can be used to facilitate iterating through a
-- structure pointer chain that returns data back to the application.
--
-- = See Also
--
-- 'BaseOutStructure',
-- 'Graphics.Vulkan.Core10.Enums.StructureType.StructureType'
data BaseOutStructure = BaseOutStructure
  { -- | @sType@ is the structure type of the structure being iterated through.
    sType :: StructureType
  , -- | @pNext@ is @NULL@ or a pointer to the next structure in a structure
    -- chain.
    next :: Ptr BaseOutStructure
  }
  deriving (Typeable)
deriving instance Show BaseOutStructure

instance ToCStruct BaseOutStructure where
  withCStruct x f = allocaBytesAligned 16 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p BaseOutStructure{..} f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (sType)
    poke ((p `plusPtr` 8 :: Ptr (Ptr BaseOutStructure))) (next)
    f
  cStructSize = 16
  cStructAlignment = 8
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (zero)
    poke ((p `plusPtr` 8 :: Ptr (Ptr BaseOutStructure))) (zero)
    f

instance FromCStruct BaseOutStructure where
  peekCStruct p = do
    sType <- peek @StructureType ((p `plusPtr` 0 :: Ptr StructureType))
    pNext <- peek @(Ptr BaseOutStructure) ((p `plusPtr` 8 :: Ptr (Ptr BaseOutStructure)))
    pure $ BaseOutStructure
             sType pNext

instance Storable BaseOutStructure where
  sizeOf ~_ = 16
  alignment ~_ = 8
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero BaseOutStructure where
  zero = BaseOutStructure
           zero
           zero


-- | VkBaseInStructure - Base structure for a read-only pointer chain
--
-- = Description
--
-- 'BaseInStructure' can be used to facilitate iterating through a
-- read-only structure pointer chain.
--
-- = See Also
--
-- 'BaseInStructure',
-- 'Graphics.Vulkan.Core10.Enums.StructureType.StructureType'
data BaseInStructure = BaseInStructure
  { -- | @sType@ is the structure type of the structure being iterated through.
    sType :: StructureType
  , -- | @pNext@ is @NULL@ or a pointer to the next structure in a structure
    -- chain.
    next :: Ptr BaseInStructure
  }
  deriving (Typeable)
deriving instance Show BaseInStructure

instance ToCStruct BaseInStructure where
  withCStruct x f = allocaBytesAligned 16 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p BaseInStructure{..} f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (sType)
    poke ((p `plusPtr` 8 :: Ptr (Ptr BaseInStructure))) (next)
    f
  cStructSize = 16
  cStructAlignment = 8
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (zero)
    poke ((p `plusPtr` 8 :: Ptr (Ptr BaseInStructure))) (zero)
    f

instance FromCStruct BaseInStructure where
  peekCStruct p = do
    sType <- peek @StructureType ((p `plusPtr` 0 :: Ptr StructureType))
    pNext <- peek @(Ptr BaseInStructure) ((p `plusPtr` 8 :: Ptr (Ptr BaseInStructure)))
    pure $ BaseInStructure
             sType pNext

instance Storable BaseInStructure where
  sizeOf ~_ = 16
  alignment ~_ = 8
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero BaseInStructure where
  zero = BaseInStructure
           zero
           zero


type family Extends (a :: [Type] -> Type) (b :: Type) :: Constraint where
  Extends AccelerationStructureBuildGeometryInfoKHR DeferredOperationInfoKHR = ()
  Extends AndroidHardwareBufferPropertiesANDROID AndroidHardwareBufferFormatPropertiesANDROID = ()
  Extends AttachmentDescription2 AttachmentDescriptionStencilLayout = ()
  Extends AttachmentReference2 AttachmentReferenceStencilLayout = ()
  Extends BindBufferMemoryInfo BindBufferMemoryDeviceGroupInfo = ()
  Extends BindImageMemoryInfo BindImageMemoryDeviceGroupInfo = ()
  Extends BindImageMemoryInfo BindImageMemorySwapchainInfoKHR = ()
  Extends BindImageMemoryInfo BindImagePlaneMemoryInfo = ()
  Extends BindSparseInfo DeviceGroupBindSparseInfo = ()
  Extends BindSparseInfo TimelineSemaphoreSubmitInfo = ()
  Extends BufferCreateInfo DedicatedAllocationBufferCreateInfoNV = ()
  Extends BufferCreateInfo ExternalMemoryBufferCreateInfo = ()
  Extends BufferCreateInfo BufferOpaqueCaptureAddressCreateInfo = ()
  Extends BufferCreateInfo BufferDeviceAddressCreateInfoEXT = ()
  Extends CommandBufferBeginInfo DeviceGroupCommandBufferBeginInfo = ()
  Extends CommandBufferInheritanceInfo CommandBufferInheritanceConditionalRenderingInfoEXT = ()
  Extends CommandBufferInheritanceInfo CommandBufferInheritanceRenderPassTransformInfoQCOM = ()
  Extends ComputePipelineCreateInfo PipelineCreationFeedbackCreateInfoEXT = ()
  Extends ComputePipelineCreateInfo PipelineCompilerControlCreateInfoAMD = ()
  Extends CopyAccelerationStructureInfoKHR DeferredOperationInfoKHR = ()
  Extends CopyAccelerationStructureToMemoryInfoKHR DeferredOperationInfoKHR = ()
  Extends CopyMemoryToAccelerationStructureInfoKHR DeferredOperationInfoKHR = ()
  Extends DescriptorPoolCreateInfo DescriptorPoolInlineUniformBlockCreateInfoEXT = ()
  Extends DescriptorSetAllocateInfo DescriptorSetVariableDescriptorCountAllocateInfo = ()
  Extends DescriptorSetLayoutCreateInfo DescriptorSetLayoutBindingFlagsCreateInfo = ()
  Extends DescriptorSetLayoutSupport DescriptorSetVariableDescriptorCountLayoutSupport = ()
  Extends DeviceCreateInfo PhysicalDeviceDeviceGeneratedCommandsFeaturesNV = ()
  Extends DeviceCreateInfo (PhysicalDeviceFeatures2 '[]) = ()
  Extends DeviceCreateInfo PhysicalDeviceVariablePointersFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceMultiviewFeatures = ()
  Extends DeviceCreateInfo DeviceGroupDeviceCreateInfo = ()
  Extends DeviceCreateInfo PhysicalDevice16BitStorageFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderSubgroupExtendedTypesFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceSamplerYcbcrConversionFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceProtectedMemoryFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceBlendOperationAdvancedFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceInlineUniformBlockFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderDrawParametersFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderFloat16Int8Features = ()
  Extends DeviceCreateInfo PhysicalDeviceHostQueryResetFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceDescriptorIndexingFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceTimelineSemaphoreFeatures = ()
  Extends DeviceCreateInfo PhysicalDevice8BitStorageFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceConditionalRenderingFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceVulkanMemoryModelFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderAtomicInt64Features = ()
  Extends DeviceCreateInfo PhysicalDeviceVertexAttributeDivisorFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceASTCDecodeFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceTransformFeedbackFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceRepresentativeFragmentTestFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceExclusiveScissorFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceCornerSampledImageFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceComputeShaderDerivativesFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceFragmentShaderBarycentricFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderImageFootprintFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceShadingRateImageFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceMeshShaderFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceRayTracingFeaturesKHR = ()
  Extends DeviceCreateInfo DeviceMemoryOverallocationCreateInfoAMD = ()
  Extends DeviceCreateInfo PhysicalDeviceFragmentDensityMapFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceScalarBlockLayoutFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceUniformBufferStandardLayoutFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceDepthClipEnableFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceMemoryPriorityFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceBufferDeviceAddressFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceBufferDeviceAddressFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceImagelessFramebufferFeatures = ()
  Extends DeviceCreateInfo PhysicalDeviceTextureCompressionASTCHDRFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceCooperativeMatrixFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceYcbcrImageArraysFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDevicePerformanceQueryFeaturesKHR = ()
  Extends DeviceCreateInfo PhysicalDeviceCoverageReductionModeFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderClockFeaturesKHR = ()
  Extends DeviceCreateInfo PhysicalDeviceIndexTypeUint8FeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderSMBuiltinsFeaturesNV = ()
  Extends DeviceCreateInfo PhysicalDeviceFragmentShaderInterlockFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceSeparateDepthStencilLayoutsFeatures = ()
  Extends DeviceCreateInfo PhysicalDevicePipelineExecutablePropertiesFeaturesKHR = ()
  Extends DeviceCreateInfo PhysicalDeviceShaderDemoteToHelperInvocationFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceTexelBufferAlignmentFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceSubgroupSizeControlFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceLineRasterizationFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDevicePipelineCreationCacheControlFeaturesEXT = ()
  Extends DeviceCreateInfo PhysicalDeviceVulkan11Features = ()
  Extends DeviceCreateInfo PhysicalDeviceVulkan12Features = ()
  Extends DeviceCreateInfo PhysicalDeviceCoherentMemoryFeaturesAMD = ()
  Extends DeviceCreateInfo PhysicalDeviceDiagnosticsConfigFeaturesNV = ()
  Extends DeviceCreateInfo DeviceDiagnosticsConfigCreateInfoNV = ()
  Extends DeviceQueueCreateInfo DeviceQueueGlobalPriorityCreateInfoEXT = ()
  Extends FenceCreateInfo ExportFenceCreateInfo = ()
  Extends FenceCreateInfo ExportFenceWin32HandleInfoKHR = ()
  Extends FormatProperties2 DrmFormatModifierPropertiesListEXT = ()
  Extends FramebufferCreateInfo FramebufferAttachmentsCreateInfo = ()
  Extends GraphicsPipelineCreateInfo GraphicsPipelineShaderGroupsCreateInfoNV = ()
  Extends GraphicsPipelineCreateInfo PipelineDiscardRectangleStateCreateInfoEXT = ()
  Extends GraphicsPipelineCreateInfo PipelineRepresentativeFragmentTestStateCreateInfoNV = ()
  Extends GraphicsPipelineCreateInfo PipelineCreationFeedbackCreateInfoEXT = ()
  Extends GraphicsPipelineCreateInfo PipelineCompilerControlCreateInfoAMD = ()
  Extends ImageCreateInfo DedicatedAllocationImageCreateInfoNV = ()
  Extends ImageCreateInfo ExternalMemoryImageCreateInfoNV = ()
  Extends ImageCreateInfo ExternalMemoryImageCreateInfo = ()
  Extends ImageCreateInfo ImageSwapchainCreateInfoKHR = ()
  Extends ImageCreateInfo ImageFormatListCreateInfo = ()
  Extends ImageCreateInfo ExternalFormatANDROID = ()
  Extends ImageCreateInfo ImageDrmFormatModifierListCreateInfoEXT = ()
  Extends ImageCreateInfo ImageDrmFormatModifierExplicitCreateInfoEXT = ()
  Extends ImageCreateInfo ImageStencilUsageCreateInfo = ()
  Extends ImageFormatProperties2 ExternalImageFormatProperties = ()
  Extends ImageFormatProperties2 SamplerYcbcrConversionImageFormatProperties = ()
  Extends ImageFormatProperties2 TextureLODGatherFormatPropertiesAMD = ()
  Extends ImageFormatProperties2 AndroidHardwareBufferUsageANDROID = ()
  Extends ImageFormatProperties2 FilterCubicImageViewImageFormatPropertiesEXT = ()
  Extends ImageMemoryBarrier SampleLocationsInfoEXT = ()
  Extends ImageMemoryRequirementsInfo2 ImagePlaneMemoryRequirementsInfo = ()
  Extends ImageViewCreateInfo ImageViewUsageCreateInfo = ()
  Extends ImageViewCreateInfo SamplerYcbcrConversionInfo = ()
  Extends ImageViewCreateInfo ImageViewASTCDecodeModeEXT = ()
  Extends InstanceCreateInfo DebugReportCallbackCreateInfoEXT = ()
  Extends InstanceCreateInfo ValidationFlagsEXT = ()
  Extends InstanceCreateInfo ValidationFeaturesEXT = ()
  Extends InstanceCreateInfo DebugUtilsMessengerCreateInfoEXT = ()
  Extends MemoryAllocateInfo DedicatedAllocationMemoryAllocateInfoNV = ()
  Extends MemoryAllocateInfo ExportMemoryAllocateInfoNV = ()
  Extends MemoryAllocateInfo ImportMemoryWin32HandleInfoNV = ()
  Extends MemoryAllocateInfo ExportMemoryWin32HandleInfoNV = ()
  Extends MemoryAllocateInfo ExportMemoryAllocateInfo = ()
  Extends MemoryAllocateInfo ImportMemoryWin32HandleInfoKHR = ()
  Extends MemoryAllocateInfo ExportMemoryWin32HandleInfoKHR = ()
  Extends MemoryAllocateInfo ImportMemoryFdInfoKHR = ()
  Extends MemoryAllocateInfo MemoryAllocateFlagsInfo = ()
  Extends MemoryAllocateInfo MemoryDedicatedAllocateInfo = ()
  Extends MemoryAllocateInfo ImportMemoryHostPointerInfoEXT = ()
  Extends MemoryAllocateInfo ImportAndroidHardwareBufferInfoANDROID = ()
  Extends MemoryAllocateInfo MemoryPriorityAllocateInfoEXT = ()
  Extends MemoryAllocateInfo MemoryOpaqueCaptureAddressAllocateInfo = ()
  Extends MemoryRequirements2 MemoryDedicatedRequirements = ()
  Extends PhysicalDeviceExternalSemaphoreInfo SemaphoreTypeCreateInfo = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceDeviceGeneratedCommandsFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceVariablePointersFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceMultiviewFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDevice16BitStorageFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderSubgroupExtendedTypesFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceSamplerYcbcrConversionFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceProtectedMemoryFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceBlendOperationAdvancedFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceInlineUniformBlockFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderDrawParametersFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderFloat16Int8Features = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceHostQueryResetFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceDescriptorIndexingFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceTimelineSemaphoreFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDevice8BitStorageFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceConditionalRenderingFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceVulkanMemoryModelFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderAtomicInt64Features = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceVertexAttributeDivisorFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceASTCDecodeFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceTransformFeedbackFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceRepresentativeFragmentTestFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceExclusiveScissorFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceCornerSampledImageFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceComputeShaderDerivativesFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceFragmentShaderBarycentricFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderImageFootprintFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShadingRateImageFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceMeshShaderFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceRayTracingFeaturesKHR = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceFragmentDensityMapFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceScalarBlockLayoutFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceUniformBufferStandardLayoutFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceDepthClipEnableFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceMemoryPriorityFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceBufferDeviceAddressFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceBufferDeviceAddressFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceImagelessFramebufferFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceTextureCompressionASTCHDRFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceCooperativeMatrixFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceYcbcrImageArraysFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDevicePerformanceQueryFeaturesKHR = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceCoverageReductionModeFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderClockFeaturesKHR = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceIndexTypeUint8FeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderSMBuiltinsFeaturesNV = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceFragmentShaderInterlockFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceSeparateDepthStencilLayoutsFeatures = ()
  Extends PhysicalDeviceFeatures2 PhysicalDevicePipelineExecutablePropertiesFeaturesKHR = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceShaderDemoteToHelperInvocationFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceTexelBufferAlignmentFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceSubgroupSizeControlFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceLineRasterizationFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDevicePipelineCreationCacheControlFeaturesEXT = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceVulkan11Features = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceVulkan12Features = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceCoherentMemoryFeaturesAMD = ()
  Extends PhysicalDeviceFeatures2 PhysicalDeviceDiagnosticsConfigFeaturesNV = ()
  Extends PhysicalDeviceImageFormatInfo2 PhysicalDeviceExternalImageFormatInfo = ()
  Extends PhysicalDeviceImageFormatInfo2 ImageFormatListCreateInfo = ()
  Extends PhysicalDeviceImageFormatInfo2 PhysicalDeviceImageDrmFormatModifierInfoEXT = ()
  Extends PhysicalDeviceImageFormatInfo2 ImageStencilUsageCreateInfo = ()
  Extends PhysicalDeviceImageFormatInfo2 PhysicalDeviceImageViewImageFormatInfoEXT = ()
  Extends PhysicalDeviceMemoryProperties2 PhysicalDeviceMemoryBudgetPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceDeviceGeneratedCommandsPropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDevicePushDescriptorPropertiesKHR = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceDriverProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceIDProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceMultiviewProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceDiscardRectanglePropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceMultiviewPerViewAttributesPropertiesNVX = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceSubgroupProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDevicePointClippingProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceProtectedMemoryProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceSamplerFilterMinmaxProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceSampleLocationsPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceBlendOperationAdvancedPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceInlineUniformBlockPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceMaintenance3Properties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceFloatControlsProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceExternalMemoryHostPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceConservativeRasterizationPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceShaderCorePropertiesAMD = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceShaderCoreProperties2AMD = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceDescriptorIndexingProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceTimelineSemaphoreProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceVertexAttributeDivisorPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDevicePCIBusInfoPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceDepthStencilResolveProperties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceTransformFeedbackPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceShadingRateImagePropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceMeshShaderPropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceRayTracingPropertiesKHR = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceRayTracingPropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceFragmentDensityMapPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceCooperativeMatrixPropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDevicePerformanceQueryPropertiesKHR = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceShaderSMBuiltinsPropertiesNV = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceTexelBufferAlignmentPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceSubgroupSizeControlPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceLineRasterizationPropertiesEXT = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceVulkan11Properties = ()
  Extends PhysicalDeviceProperties2 PhysicalDeviceVulkan12Properties = ()
  Extends PhysicalDeviceSurfaceInfo2KHR SurfaceFullScreenExclusiveInfoEXT = ()
  Extends PhysicalDeviceSurfaceInfo2KHR SurfaceFullScreenExclusiveWin32InfoEXT = ()
  Extends PipelineColorBlendStateCreateInfo PipelineColorBlendAdvancedStateCreateInfoEXT = ()
  Extends PipelineMultisampleStateCreateInfo PipelineCoverageToColorStateCreateInfoNV = ()
  Extends PipelineMultisampleStateCreateInfo PipelineSampleLocationsStateCreateInfoEXT = ()
  Extends PipelineMultisampleStateCreateInfo PipelineCoverageModulationStateCreateInfoNV = ()
  Extends PipelineMultisampleStateCreateInfo PipelineCoverageReductionStateCreateInfoNV = ()
  Extends PipelineRasterizationStateCreateInfo PipelineRasterizationStateRasterizationOrderAMD = ()
  Extends PipelineRasterizationStateCreateInfo PipelineRasterizationConservativeStateCreateInfoEXT = ()
  Extends PipelineRasterizationStateCreateInfo PipelineRasterizationStateStreamCreateInfoEXT = ()
  Extends PipelineRasterizationStateCreateInfo PipelineRasterizationDepthClipStateCreateInfoEXT = ()
  Extends PipelineRasterizationStateCreateInfo PipelineRasterizationLineStateCreateInfoEXT = ()
  Extends PipelineShaderStageCreateInfo PipelineShaderStageRequiredSubgroupSizeCreateInfoEXT = ()
  Extends PipelineTessellationStateCreateInfo PipelineTessellationDomainOriginStateCreateInfo = ()
  Extends PipelineVertexInputStateCreateInfo PipelineVertexInputDivisorStateCreateInfoEXT = ()
  Extends PipelineViewportStateCreateInfo PipelineViewportWScalingStateCreateInfoNV = ()
  Extends PipelineViewportStateCreateInfo PipelineViewportSwizzleStateCreateInfoNV = ()
  Extends PipelineViewportStateCreateInfo PipelineViewportExclusiveScissorStateCreateInfoNV = ()
  Extends PipelineViewportStateCreateInfo PipelineViewportShadingRateImageStateCreateInfoNV = ()
  Extends PipelineViewportStateCreateInfo PipelineViewportCoarseSampleOrderStateCreateInfoNV = ()
  Extends PresentInfoKHR DisplayPresentInfoKHR = ()
  Extends PresentInfoKHR PresentRegionsKHR = ()
  Extends PresentInfoKHR DeviceGroupPresentInfoKHR = ()
  Extends PresentInfoKHR PresentTimesInfoGOOGLE = ()
  Extends PresentInfoKHR PresentFrameTokenGGP = ()
  Extends QueryPoolCreateInfo QueryPoolPerformanceCreateInfoKHR = ()
  Extends QueryPoolCreateInfo QueryPoolPerformanceQueryCreateInfoINTEL = ()
  Extends QueueFamilyProperties2 QueueFamilyCheckpointPropertiesNV = ()
  Extends RayTracingPipelineCreateInfoKHR PipelineCreationFeedbackCreateInfoEXT = ()
  Extends RayTracingPipelineCreateInfoKHR DeferredOperationInfoKHR = ()
  Extends RayTracingPipelineCreateInfoNV PipelineCreationFeedbackCreateInfoEXT = ()
  Extends RenderPassBeginInfo DeviceGroupRenderPassBeginInfo = ()
  Extends RenderPassBeginInfo RenderPassSampleLocationsBeginInfoEXT = ()
  Extends RenderPassBeginInfo RenderPassAttachmentBeginInfo = ()
  Extends RenderPassBeginInfo RenderPassTransformBeginInfoQCOM = ()
  Extends RenderPassCreateInfo RenderPassMultiviewCreateInfo = ()
  Extends RenderPassCreateInfo RenderPassInputAttachmentAspectCreateInfo = ()
  Extends RenderPassCreateInfo RenderPassFragmentDensityMapCreateInfoEXT = ()
  Extends RenderPassCreateInfo2 RenderPassFragmentDensityMapCreateInfoEXT = ()
  Extends SamplerCreateInfo SamplerYcbcrConversionInfo = ()
  Extends SamplerCreateInfo SamplerReductionModeCreateInfo = ()
  Extends SamplerYcbcrConversionCreateInfo ExternalFormatANDROID = ()
  Extends SemaphoreCreateInfo ExportSemaphoreCreateInfo = ()
  Extends SemaphoreCreateInfo ExportSemaphoreWin32HandleInfoKHR = ()
  Extends SemaphoreCreateInfo SemaphoreTypeCreateInfo = ()
  Extends ShaderModuleCreateInfo ShaderModuleValidationCacheCreateInfoEXT = ()
  Extends SubmitInfo Win32KeyedMutexAcquireReleaseInfoNV = ()
  Extends SubmitInfo Win32KeyedMutexAcquireReleaseInfoKHR = ()
  Extends SubmitInfo D3D12FenceSubmitInfoKHR = ()
  Extends SubmitInfo DeviceGroupSubmitInfo = ()
  Extends SubmitInfo ProtectedSubmitInfo = ()
  Extends SubmitInfo TimelineSemaphoreSubmitInfo = ()
  Extends SubmitInfo PerformanceQuerySubmitInfoKHR = ()
  Extends SubpassDescription2 SubpassDescriptionDepthStencilResolve = ()
  Extends SurfaceCapabilities2KHR DisplayNativeHdrSurfaceCapabilitiesAMD = ()
  Extends SurfaceCapabilities2KHR SharedPresentSurfaceCapabilitiesKHR = ()
  Extends SurfaceCapabilities2KHR SurfaceProtectedCapabilitiesKHR = ()
  Extends SurfaceCapabilities2KHR SurfaceCapabilitiesFullScreenExclusiveEXT = ()
  Extends SwapchainCreateInfoKHR SwapchainCounterCreateInfoEXT = ()
  Extends SwapchainCreateInfoKHR DeviceGroupSwapchainCreateInfoKHR = ()
  Extends SwapchainCreateInfoKHR SwapchainDisplayNativeHdrCreateInfoAMD = ()
  Extends SwapchainCreateInfoKHR ImageFormatListCreateInfo = ()
  Extends SwapchainCreateInfoKHR SurfaceFullScreenExclusiveInfoEXT = ()
  Extends SwapchainCreateInfoKHR SurfaceFullScreenExclusiveWin32InfoEXT = ()
  Extends WriteDescriptorSet WriteDescriptorSetInlineUniformBlockEXT = ()
  Extends WriteDescriptorSet WriteDescriptorSetAccelerationStructureKHR = ()
  Extends a b = TypeError (ShowType a :<>: Text " is not extended by " :<>: ShowType b)

data SomeStruct (a :: [Type] -> Type) where
  SomeStruct
    :: forall a es
     . (Extendss a es, PokeChain es, Show (Chain es))
    => a es
    -> SomeStruct a

deriving instance (forall es. Show (Chain es) => Show (a es)) => Show (SomeStruct a)

instance Zero (a '[]) => Zero (SomeStruct a) where
  zero = SomeStruct (zero :: a '[])

forgetExtensions :: Ptr (a es) -> Ptr (SomeStruct a)
forgetExtensions = castPtr

withSomeCStruct
  :: forall a b
   . (forall es . PokeChain es => ToCStruct (a es))
  => SomeStruct a
  -> (forall es . (Extendss a es, PokeChain es) => Ptr (a es) -> IO b)
  -> IO b
withSomeCStruct (SomeStruct s) f = withCStruct s f

pokeSomeCStruct
  :: (forall es . PokeChain es => ToCStruct (a es))
  => Ptr (SomeStruct a)
  -> SomeStruct a
  -> IO b
  -> IO b
pokeSomeCStruct p (SomeStruct s) = pokeCStruct (castPtr p) s

peekSomeCStruct
  :: forall a
   . (Extensible a, forall es . (Extendss a es, PeekChain es) => FromCStruct (a es))
  => Ptr (SomeStruct a)
  -> IO (SomeStruct a)
peekSomeCStruct p = do
  head'  <- peekCStruct (castPtr @_ @(a '[]) p)
  pNext <- peek @(Ptr BaseOutStructure) (p `plusPtr` 8)
  peekSomeChain @a pNext $ \tail' -> SomeStruct (setNext head' tail')

peekSomeChain
  :: forall
       a
       b
   . (Extensible a)
  => Ptr BaseOutStructure
  -> (  forall es
      . (Extendss a es, PokeChain es, Show (Chain es))
     => Chain es
     -> b
     )
  -> IO b
peekSomeChain p c = if p == nullPtr
  then pure (c ())
  else do
    baseOut <- peek p
    join
      $ peekChainHead @a (sType (baseOut :: BaseOutStructure))
                         (castPtr @BaseOutStructure @() p)
      $ \head' -> peekSomeChain @a (next (baseOut :: BaseOutStructure))
                                  (\tail' -> c (head', tail'))


peekChainHead
  :: forall a b
   . Extensible a
  => StructureType
  -> Ptr ()
  -> (forall e . (Extends a e, ToCStruct e, Show e) => e -> b)
  -> IO b
peekChainHead ty p c = case ty of
  STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR -> go @DisplayPresentInfoKHR
  STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT -> go @DebugReportCallbackCreateInfoEXT
  STRUCTURE_TYPE_VALIDATION_FLAGS_EXT -> go @ValidationFlagsEXT
  STRUCTURE_TYPE_VALIDATION_FEATURES_EXT -> go @ValidationFeaturesEXT
  STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD -> go @PipelineRasterizationStateRasterizationOrderAMD
  STRUCTURE_TYPE_DEDICATED_ALLOCATION_IMAGE_CREATE_INFO_NV -> go @DedicatedAllocationImageCreateInfoNV
  STRUCTURE_TYPE_DEDICATED_ALLOCATION_BUFFER_CREATE_INFO_NV -> go @DedicatedAllocationBufferCreateInfoNV
  STRUCTURE_TYPE_DEDICATED_ALLOCATION_MEMORY_ALLOCATE_INFO_NV -> go @DedicatedAllocationMemoryAllocateInfoNV
  STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV -> go @ExternalMemoryImageCreateInfoNV
  STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO_NV -> go @ExportMemoryAllocateInfoNV
  STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_NV -> go @ImportMemoryWin32HandleInfoNV
  STRUCTURE_TYPE_EXPORT_MEMORY_WIN32_HANDLE_INFO_NV -> go @ExportMemoryWin32HandleInfoNV
  STRUCTURE_TYPE_WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_NV -> go @Win32KeyedMutexAcquireReleaseInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_FEATURES_NV -> go @PhysicalDeviceDeviceGeneratedCommandsFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_PROPERTIES_NV -> go @PhysicalDeviceDeviceGeneratedCommandsPropertiesNV
  STRUCTURE_TYPE_GRAPHICS_PIPELINE_SHADER_GROUPS_CREATE_INFO_NV -> go @GraphicsPipelineShaderGroupsCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 -> go @(PhysicalDeviceFeatures2 '[])
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR -> go @PhysicalDevicePushDescriptorPropertiesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES -> go @PhysicalDeviceDriverProperties
  STRUCTURE_TYPE_PRESENT_REGIONS_KHR -> go @PresentRegionsKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VARIABLE_POINTERS_FEATURES -> go @PhysicalDeviceVariablePointersFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_IMAGE_FORMAT_INFO -> go @PhysicalDeviceExternalImageFormatInfo
  STRUCTURE_TYPE_EXTERNAL_IMAGE_FORMAT_PROPERTIES -> go @ExternalImageFormatProperties
  STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES -> go @PhysicalDeviceIDProperties
  STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO -> go @ExternalMemoryImageCreateInfo
  STRUCTURE_TYPE_EXTERNAL_MEMORY_BUFFER_CREATE_INFO -> go @ExternalMemoryBufferCreateInfo
  STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO -> go @ExportMemoryAllocateInfo
  STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_KHR -> go @ImportMemoryWin32HandleInfoKHR
  STRUCTURE_TYPE_EXPORT_MEMORY_WIN32_HANDLE_INFO_KHR -> go @ExportMemoryWin32HandleInfoKHR
  STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR -> go @ImportMemoryFdInfoKHR
  STRUCTURE_TYPE_WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_KHR -> go @Win32KeyedMutexAcquireReleaseInfoKHR
  STRUCTURE_TYPE_EXPORT_SEMAPHORE_CREATE_INFO -> go @ExportSemaphoreCreateInfo
  STRUCTURE_TYPE_EXPORT_SEMAPHORE_WIN32_HANDLE_INFO_KHR -> go @ExportSemaphoreWin32HandleInfoKHR
  STRUCTURE_TYPE_D3D12_FENCE_SUBMIT_INFO_KHR -> go @D3D12FenceSubmitInfoKHR
  STRUCTURE_TYPE_EXPORT_FENCE_CREATE_INFO -> go @ExportFenceCreateInfo
  STRUCTURE_TYPE_EXPORT_FENCE_WIN32_HANDLE_INFO_KHR -> go @ExportFenceWin32HandleInfoKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MULTIVIEW_FEATURES -> go @PhysicalDeviceMultiviewFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MULTIVIEW_PROPERTIES -> go @PhysicalDeviceMultiviewProperties
  STRUCTURE_TYPE_RENDER_PASS_MULTIVIEW_CREATE_INFO -> go @RenderPassMultiviewCreateInfo
  STRUCTURE_TYPE_SWAPCHAIN_COUNTER_CREATE_INFO_EXT -> go @SwapchainCounterCreateInfoEXT
  STRUCTURE_TYPE_MEMORY_ALLOCATE_FLAGS_INFO -> go @MemoryAllocateFlagsInfo
  STRUCTURE_TYPE_BIND_BUFFER_MEMORY_DEVICE_GROUP_INFO -> go @BindBufferMemoryDeviceGroupInfo
  STRUCTURE_TYPE_BIND_IMAGE_MEMORY_DEVICE_GROUP_INFO -> go @BindImageMemoryDeviceGroupInfo
  STRUCTURE_TYPE_DEVICE_GROUP_RENDER_PASS_BEGIN_INFO -> go @DeviceGroupRenderPassBeginInfo
  STRUCTURE_TYPE_DEVICE_GROUP_COMMAND_BUFFER_BEGIN_INFO -> go @DeviceGroupCommandBufferBeginInfo
  STRUCTURE_TYPE_DEVICE_GROUP_SUBMIT_INFO -> go @DeviceGroupSubmitInfo
  STRUCTURE_TYPE_DEVICE_GROUP_BIND_SPARSE_INFO -> go @DeviceGroupBindSparseInfo
  STRUCTURE_TYPE_IMAGE_SWAPCHAIN_CREATE_INFO_KHR -> go @ImageSwapchainCreateInfoKHR
  STRUCTURE_TYPE_BIND_IMAGE_MEMORY_SWAPCHAIN_INFO_KHR -> go @BindImageMemorySwapchainInfoKHR
  STRUCTURE_TYPE_DEVICE_GROUP_PRESENT_INFO_KHR -> go @DeviceGroupPresentInfoKHR
  STRUCTURE_TYPE_DEVICE_GROUP_DEVICE_CREATE_INFO -> go @DeviceGroupDeviceCreateInfo
  STRUCTURE_TYPE_DEVICE_GROUP_SWAPCHAIN_CREATE_INFO_KHR -> go @DeviceGroupSwapchainCreateInfoKHR
  STRUCTURE_TYPE_DISPLAY_NATIVE_HDR_SURFACE_CAPABILITIES_AMD -> go @DisplayNativeHdrSurfaceCapabilitiesAMD
  STRUCTURE_TYPE_SWAPCHAIN_DISPLAY_NATIVE_HDR_CREATE_INFO_AMD -> go @SwapchainDisplayNativeHdrCreateInfoAMD
  STRUCTURE_TYPE_PRESENT_TIMES_INFO_GOOGLE -> go @PresentTimesInfoGOOGLE
  STRUCTURE_TYPE_PIPELINE_VIEWPORT_W_SCALING_STATE_CREATE_INFO_NV -> go @PipelineViewportWScalingStateCreateInfoNV
  STRUCTURE_TYPE_PIPELINE_VIEWPORT_SWIZZLE_STATE_CREATE_INFO_NV -> go @PipelineViewportSwizzleStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DISCARD_RECTANGLE_PROPERTIES_EXT -> go @PhysicalDeviceDiscardRectanglePropertiesEXT
  STRUCTURE_TYPE_PIPELINE_DISCARD_RECTANGLE_STATE_CREATE_INFO_EXT -> go @PipelineDiscardRectangleStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MULTIVIEW_PER_VIEW_ATTRIBUTES_PROPERTIES_NVX -> go @PhysicalDeviceMultiviewPerViewAttributesPropertiesNVX
  STRUCTURE_TYPE_RENDER_PASS_INPUT_ATTACHMENT_ASPECT_CREATE_INFO -> go @RenderPassInputAttachmentAspectCreateInfo
  STRUCTURE_TYPE_SHARED_PRESENT_SURFACE_CAPABILITIES_KHR -> go @SharedPresentSurfaceCapabilitiesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_16BIT_STORAGE_FEATURES -> go @PhysicalDevice16BitStorageFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SUBGROUP_PROPERTIES -> go @PhysicalDeviceSubgroupProperties
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_SUBGROUP_EXTENDED_TYPES_FEATURES -> go @PhysicalDeviceShaderSubgroupExtendedTypesFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_POINT_CLIPPING_PROPERTIES -> go @PhysicalDevicePointClippingProperties
  STRUCTURE_TYPE_MEMORY_DEDICATED_REQUIREMENTS -> go @MemoryDedicatedRequirements
  STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO -> go @MemoryDedicatedAllocateInfo
  STRUCTURE_TYPE_IMAGE_VIEW_USAGE_CREATE_INFO -> go @ImageViewUsageCreateInfo
  STRUCTURE_TYPE_PIPELINE_TESSELLATION_DOMAIN_ORIGIN_STATE_CREATE_INFO -> go @PipelineTessellationDomainOriginStateCreateInfo
  STRUCTURE_TYPE_SAMPLER_YCBCR_CONVERSION_INFO -> go @SamplerYcbcrConversionInfo
  STRUCTURE_TYPE_BIND_IMAGE_PLANE_MEMORY_INFO -> go @BindImagePlaneMemoryInfo
  STRUCTURE_TYPE_IMAGE_PLANE_MEMORY_REQUIREMENTS_INFO -> go @ImagePlaneMemoryRequirementsInfo
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SAMPLER_YCBCR_CONVERSION_FEATURES -> go @PhysicalDeviceSamplerYcbcrConversionFeatures
  STRUCTURE_TYPE_SAMPLER_YCBCR_CONVERSION_IMAGE_FORMAT_PROPERTIES -> go @SamplerYcbcrConversionImageFormatProperties
  STRUCTURE_TYPE_TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD -> go @TextureLODGatherFormatPropertiesAMD
  STRUCTURE_TYPE_PROTECTED_SUBMIT_INFO -> go @ProtectedSubmitInfo
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PROTECTED_MEMORY_FEATURES -> go @PhysicalDeviceProtectedMemoryFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PROTECTED_MEMORY_PROPERTIES -> go @PhysicalDeviceProtectedMemoryProperties
  STRUCTURE_TYPE_PIPELINE_COVERAGE_TO_COLOR_STATE_CREATE_INFO_NV -> go @PipelineCoverageToColorStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SAMPLER_FILTER_MINMAX_PROPERTIES -> go @PhysicalDeviceSamplerFilterMinmaxProperties
  STRUCTURE_TYPE_SAMPLE_LOCATIONS_INFO_EXT -> go @SampleLocationsInfoEXT
  STRUCTURE_TYPE_RENDER_PASS_SAMPLE_LOCATIONS_BEGIN_INFO_EXT -> go @RenderPassSampleLocationsBeginInfoEXT
  STRUCTURE_TYPE_PIPELINE_SAMPLE_LOCATIONS_STATE_CREATE_INFO_EXT -> go @PipelineSampleLocationsStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SAMPLE_LOCATIONS_PROPERTIES_EXT -> go @PhysicalDeviceSampleLocationsPropertiesEXT
  STRUCTURE_TYPE_SAMPLER_REDUCTION_MODE_CREATE_INFO -> go @SamplerReductionModeCreateInfo
  STRUCTURE_TYPE_PHYSICAL_DEVICE_BLEND_OPERATION_ADVANCED_FEATURES_EXT -> go @PhysicalDeviceBlendOperationAdvancedFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_BLEND_OPERATION_ADVANCED_PROPERTIES_EXT -> go @PhysicalDeviceBlendOperationAdvancedPropertiesEXT
  STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_ADVANCED_STATE_CREATE_INFO_EXT -> go @PipelineColorBlendAdvancedStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_FEATURES_EXT -> go @PhysicalDeviceInlineUniformBlockFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_PROPERTIES_EXT -> go @PhysicalDeviceInlineUniformBlockPropertiesEXT
  STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET_INLINE_UNIFORM_BLOCK_EXT -> go @WriteDescriptorSetInlineUniformBlockEXT
  STRUCTURE_TYPE_DESCRIPTOR_POOL_INLINE_UNIFORM_BLOCK_CREATE_INFO_EXT -> go @DescriptorPoolInlineUniformBlockCreateInfoEXT
  STRUCTURE_TYPE_PIPELINE_COVERAGE_MODULATION_STATE_CREATE_INFO_NV -> go @PipelineCoverageModulationStateCreateInfoNV
  STRUCTURE_TYPE_IMAGE_FORMAT_LIST_CREATE_INFO -> go @ImageFormatListCreateInfo
  STRUCTURE_TYPE_SHADER_MODULE_VALIDATION_CACHE_CREATE_INFO_EXT -> go @ShaderModuleValidationCacheCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MAINTENANCE_3_PROPERTIES -> go @PhysicalDeviceMaintenance3Properties
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_DRAW_PARAMETERS_FEATURES -> go @PhysicalDeviceShaderDrawParametersFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_FLOAT16_INT8_FEATURES -> go @PhysicalDeviceShaderFloat16Int8Features
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FLOAT_CONTROLS_PROPERTIES -> go @PhysicalDeviceFloatControlsProperties
  STRUCTURE_TYPE_PHYSICAL_DEVICE_HOST_QUERY_RESET_FEATURES -> go @PhysicalDeviceHostQueryResetFeatures
  STRUCTURE_TYPE_DEVICE_QUEUE_GLOBAL_PRIORITY_CREATE_INFO_EXT -> go @DeviceQueueGlobalPriorityCreateInfoEXT
  STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT -> go @DebugUtilsMessengerCreateInfoEXT
  STRUCTURE_TYPE_IMPORT_MEMORY_HOST_POINTER_INFO_EXT -> go @ImportMemoryHostPointerInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_MEMORY_HOST_PROPERTIES_EXT -> go @PhysicalDeviceExternalMemoryHostPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_CONSERVATIVE_RASTERIZATION_PROPERTIES_EXT -> go @PhysicalDeviceConservativeRasterizationPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_CORE_PROPERTIES_AMD -> go @PhysicalDeviceShaderCorePropertiesAMD
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_CORE_PROPERTIES_2_AMD -> go @PhysicalDeviceShaderCoreProperties2AMD
  STRUCTURE_TYPE_PIPELINE_RASTERIZATION_CONSERVATIVE_STATE_CREATE_INFO_EXT -> go @PipelineRasterizationConservativeStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_FEATURES -> go @PhysicalDeviceDescriptorIndexingFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_PROPERTIES -> go @PhysicalDeviceDescriptorIndexingProperties
  STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_BINDING_FLAGS_CREATE_INFO -> go @DescriptorSetLayoutBindingFlagsCreateInfo
  STRUCTURE_TYPE_DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_ALLOCATE_INFO -> go @DescriptorSetVariableDescriptorCountAllocateInfo
  STRUCTURE_TYPE_DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_LAYOUT_SUPPORT -> go @DescriptorSetVariableDescriptorCountLayoutSupport
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_FEATURES -> go @PhysicalDeviceTimelineSemaphoreFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_PROPERTIES -> go @PhysicalDeviceTimelineSemaphoreProperties
  STRUCTURE_TYPE_SEMAPHORE_TYPE_CREATE_INFO -> go @SemaphoreTypeCreateInfo
  STRUCTURE_TYPE_TIMELINE_SEMAPHORE_SUBMIT_INFO -> go @TimelineSemaphoreSubmitInfo
  STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_DIVISOR_STATE_CREATE_INFO_EXT -> go @PipelineVertexInputDivisorStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_PROPERTIES_EXT -> go @PhysicalDeviceVertexAttributeDivisorPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PCI_BUS_INFO_PROPERTIES_EXT -> go @PhysicalDevicePCIBusInfoPropertiesEXT
  STRUCTURE_TYPE_IMPORT_ANDROID_HARDWARE_BUFFER_INFO_ANDROID -> go @ImportAndroidHardwareBufferInfoANDROID
  STRUCTURE_TYPE_ANDROID_HARDWARE_BUFFER_USAGE_ANDROID -> go @AndroidHardwareBufferUsageANDROID
  STRUCTURE_TYPE_ANDROID_HARDWARE_BUFFER_FORMAT_PROPERTIES_ANDROID -> go @AndroidHardwareBufferFormatPropertiesANDROID
  STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_CONDITIONAL_RENDERING_INFO_EXT -> go @CommandBufferInheritanceConditionalRenderingInfoEXT
  STRUCTURE_TYPE_EXTERNAL_FORMAT_ANDROID -> go @ExternalFormatANDROID
  STRUCTURE_TYPE_PHYSICAL_DEVICE_8BIT_STORAGE_FEATURES -> go @PhysicalDevice8BitStorageFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_CONDITIONAL_RENDERING_FEATURES_EXT -> go @PhysicalDeviceConditionalRenderingFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_MEMORY_MODEL_FEATURES -> go @PhysicalDeviceVulkanMemoryModelFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_ATOMIC_INT64_FEATURES -> go @PhysicalDeviceShaderAtomicInt64Features
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_FEATURES_EXT -> go @PhysicalDeviceVertexAttributeDivisorFeaturesEXT
  STRUCTURE_TYPE_QUEUE_FAMILY_CHECKPOINT_PROPERTIES_NV -> go @QueueFamilyCheckpointPropertiesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DEPTH_STENCIL_RESOLVE_PROPERTIES -> go @PhysicalDeviceDepthStencilResolveProperties
  STRUCTURE_TYPE_SUBPASS_DESCRIPTION_DEPTH_STENCIL_RESOLVE -> go @SubpassDescriptionDepthStencilResolve
  STRUCTURE_TYPE_IMAGE_VIEW_ASTC_DECODE_MODE_EXT -> go @ImageViewASTCDecodeModeEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_ASTC_DECODE_FEATURES_EXT -> go @PhysicalDeviceASTCDecodeFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TRANSFORM_FEEDBACK_FEATURES_EXT -> go @PhysicalDeviceTransformFeedbackFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TRANSFORM_FEEDBACK_PROPERTIES_EXT -> go @PhysicalDeviceTransformFeedbackPropertiesEXT
  STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_STREAM_CREATE_INFO_EXT -> go @PipelineRasterizationStateStreamCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_REPRESENTATIVE_FRAGMENT_TEST_FEATURES_NV -> go @PhysicalDeviceRepresentativeFragmentTestFeaturesNV
  STRUCTURE_TYPE_PIPELINE_REPRESENTATIVE_FRAGMENT_TEST_STATE_CREATE_INFO_NV -> go @PipelineRepresentativeFragmentTestStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_EXCLUSIVE_SCISSOR_FEATURES_NV -> go @PhysicalDeviceExclusiveScissorFeaturesNV
  STRUCTURE_TYPE_PIPELINE_VIEWPORT_EXCLUSIVE_SCISSOR_STATE_CREATE_INFO_NV -> go @PipelineViewportExclusiveScissorStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV -> go @PhysicalDeviceCornerSampledImageFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_COMPUTE_SHADER_DERIVATIVES_FEATURES_NV -> go @PhysicalDeviceComputeShaderDerivativesFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FRAGMENT_SHADER_BARYCENTRIC_FEATURES_NV -> go @PhysicalDeviceFragmentShaderBarycentricFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_IMAGE_FOOTPRINT_FEATURES_NV -> go @PhysicalDeviceShaderImageFootprintFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DEDICATED_ALLOCATION_IMAGE_ALIASING_FEATURES_NV -> go @PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV
  STRUCTURE_TYPE_PIPELINE_VIEWPORT_SHADING_RATE_IMAGE_STATE_CREATE_INFO_NV -> go @PipelineViewportShadingRateImageStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADING_RATE_IMAGE_FEATURES_NV -> go @PhysicalDeviceShadingRateImageFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADING_RATE_IMAGE_PROPERTIES_NV -> go @PhysicalDeviceShadingRateImagePropertiesNV
  STRUCTURE_TYPE_PIPELINE_VIEWPORT_COARSE_SAMPLE_ORDER_STATE_CREATE_INFO_NV -> go @PipelineViewportCoarseSampleOrderStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MESH_SHADER_FEATURES_NV -> go @PhysicalDeviceMeshShaderFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MESH_SHADER_PROPERTIES_NV -> go @PhysicalDeviceMeshShaderPropertiesNV
  STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET_ACCELERATION_STRUCTURE_KHR -> go @WriteDescriptorSetAccelerationStructureKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_TRACING_FEATURES_KHR -> go @PhysicalDeviceRayTracingFeaturesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_TRACING_PROPERTIES_KHR -> go @PhysicalDeviceRayTracingPropertiesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_TRACING_PROPERTIES_NV -> go @PhysicalDeviceRayTracingPropertiesNV
  STRUCTURE_TYPE_DRM_FORMAT_MODIFIER_PROPERTIES_LIST_EXT -> go @DrmFormatModifierPropertiesListEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_DRM_FORMAT_MODIFIER_INFO_EXT -> go @PhysicalDeviceImageDrmFormatModifierInfoEXT
  STRUCTURE_TYPE_IMAGE_DRM_FORMAT_MODIFIER_LIST_CREATE_INFO_EXT -> go @ImageDrmFormatModifierListCreateInfoEXT
  STRUCTURE_TYPE_IMAGE_DRM_FORMAT_MODIFIER_EXPLICIT_CREATE_INFO_EXT -> go @ImageDrmFormatModifierExplicitCreateInfoEXT
  STRUCTURE_TYPE_IMAGE_STENCIL_USAGE_CREATE_INFO -> go @ImageStencilUsageCreateInfo
  STRUCTURE_TYPE_DEVICE_MEMORY_OVERALLOCATION_CREATE_INFO_AMD -> go @DeviceMemoryOverallocationCreateInfoAMD
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_FEATURES_EXT -> go @PhysicalDeviceFragmentDensityMapFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_PROPERTIES_EXT -> go @PhysicalDeviceFragmentDensityMapPropertiesEXT
  STRUCTURE_TYPE_RENDER_PASS_FRAGMENT_DENSITY_MAP_CREATE_INFO_EXT -> go @RenderPassFragmentDensityMapCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SCALAR_BLOCK_LAYOUT_FEATURES -> go @PhysicalDeviceScalarBlockLayoutFeatures
  STRUCTURE_TYPE_SURFACE_PROTECTED_CAPABILITIES_KHR -> go @SurfaceProtectedCapabilitiesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_UNIFORM_BUFFER_STANDARD_LAYOUT_FEATURES -> go @PhysicalDeviceUniformBufferStandardLayoutFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DEPTH_CLIP_ENABLE_FEATURES_EXT -> go @PhysicalDeviceDepthClipEnableFeaturesEXT
  STRUCTURE_TYPE_PIPELINE_RASTERIZATION_DEPTH_CLIP_STATE_CREATE_INFO_EXT -> go @PipelineRasterizationDepthClipStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_BUDGET_PROPERTIES_EXT -> go @PhysicalDeviceMemoryBudgetPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_MEMORY_PRIORITY_FEATURES_EXT -> go @PhysicalDeviceMemoryPriorityFeaturesEXT
  STRUCTURE_TYPE_MEMORY_PRIORITY_ALLOCATE_INFO_EXT -> go @MemoryPriorityAllocateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_BUFFER_DEVICE_ADDRESS_FEATURES -> go @PhysicalDeviceBufferDeviceAddressFeatures
  STRUCTURE_TYPE_PHYSICAL_DEVICE_BUFFER_DEVICE_ADDRESS_FEATURES_EXT -> go @PhysicalDeviceBufferDeviceAddressFeaturesEXT
  STRUCTURE_TYPE_BUFFER_OPAQUE_CAPTURE_ADDRESS_CREATE_INFO -> go @BufferOpaqueCaptureAddressCreateInfo
  STRUCTURE_TYPE_BUFFER_DEVICE_ADDRESS_CREATE_INFO_EXT -> go @BufferDeviceAddressCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_VIEW_IMAGE_FORMAT_INFO_EXT -> go @PhysicalDeviceImageViewImageFormatInfoEXT
  STRUCTURE_TYPE_FILTER_CUBIC_IMAGE_VIEW_IMAGE_FORMAT_PROPERTIES_EXT -> go @FilterCubicImageViewImageFormatPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGELESS_FRAMEBUFFER_FEATURES -> go @PhysicalDeviceImagelessFramebufferFeatures
  STRUCTURE_TYPE_FRAMEBUFFER_ATTACHMENTS_CREATE_INFO -> go @FramebufferAttachmentsCreateInfo
  STRUCTURE_TYPE_RENDER_PASS_ATTACHMENT_BEGIN_INFO -> go @RenderPassAttachmentBeginInfo
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TEXTURE_COMPRESSION_ASTC_HDR_FEATURES_EXT -> go @PhysicalDeviceTextureCompressionASTCHDRFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_COOPERATIVE_MATRIX_FEATURES_NV -> go @PhysicalDeviceCooperativeMatrixFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_COOPERATIVE_MATRIX_PROPERTIES_NV -> go @PhysicalDeviceCooperativeMatrixPropertiesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_YCBCR_IMAGE_ARRAYS_FEATURES_EXT -> go @PhysicalDeviceYcbcrImageArraysFeaturesEXT
  STRUCTURE_TYPE_PRESENT_FRAME_TOKEN_GGP -> go @PresentFrameTokenGGP
  STRUCTURE_TYPE_PIPELINE_CREATION_FEEDBACK_CREATE_INFO_EXT -> go @PipelineCreationFeedbackCreateInfoEXT
  STRUCTURE_TYPE_SURFACE_FULL_SCREEN_EXCLUSIVE_INFO_EXT -> go @SurfaceFullScreenExclusiveInfoEXT
  STRUCTURE_TYPE_SURFACE_FULL_SCREEN_EXCLUSIVE_WIN32_INFO_EXT -> go @SurfaceFullScreenExclusiveWin32InfoEXT
  STRUCTURE_TYPE_SURFACE_CAPABILITIES_FULL_SCREEN_EXCLUSIVE_EXT -> go @SurfaceCapabilitiesFullScreenExclusiveEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PERFORMANCE_QUERY_FEATURES_KHR -> go @PhysicalDevicePerformanceQueryFeaturesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PERFORMANCE_QUERY_PROPERTIES_KHR -> go @PhysicalDevicePerformanceQueryPropertiesKHR
  STRUCTURE_TYPE_QUERY_POOL_PERFORMANCE_CREATE_INFO_KHR -> go @QueryPoolPerformanceCreateInfoKHR
  STRUCTURE_TYPE_PERFORMANCE_QUERY_SUBMIT_INFO_KHR -> go @PerformanceQuerySubmitInfoKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_COVERAGE_REDUCTION_MODE_FEATURES_NV -> go @PhysicalDeviceCoverageReductionModeFeaturesNV
  STRUCTURE_TYPE_PIPELINE_COVERAGE_REDUCTION_STATE_CREATE_INFO_NV -> go @PipelineCoverageReductionStateCreateInfoNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_INTEGER_FUNCTIONS_2_FEATURES_INTEL -> go @PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL
  STRUCTURE_TYPE_QUERY_POOL_PERFORMANCE_QUERY_CREATE_INFO_INTEL -> go @QueryPoolPerformanceQueryCreateInfoINTEL
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_CLOCK_FEATURES_KHR -> go @PhysicalDeviceShaderClockFeaturesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_INDEX_TYPE_UINT8_FEATURES_EXT -> go @PhysicalDeviceIndexTypeUint8FeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_SM_BUILTINS_PROPERTIES_NV -> go @PhysicalDeviceShaderSMBuiltinsPropertiesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_SM_BUILTINS_FEATURES_NV -> go @PhysicalDeviceShaderSMBuiltinsFeaturesNV
  STRUCTURE_TYPE_PHYSICAL_DEVICE_FRAGMENT_SHADER_INTERLOCK_FEATURES_EXT -> go @PhysicalDeviceFragmentShaderInterlockFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SEPARATE_DEPTH_STENCIL_LAYOUTS_FEATURES -> go @PhysicalDeviceSeparateDepthStencilLayoutsFeatures
  STRUCTURE_TYPE_ATTACHMENT_REFERENCE_STENCIL_LAYOUT -> go @AttachmentReferenceStencilLayout
  STRUCTURE_TYPE_ATTACHMENT_DESCRIPTION_STENCIL_LAYOUT -> go @AttachmentDescriptionStencilLayout
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PIPELINE_EXECUTABLE_PROPERTIES_FEATURES_KHR -> go @PhysicalDevicePipelineExecutablePropertiesFeaturesKHR
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_DEMOTE_TO_HELPER_INVOCATION_FEATURES_EXT -> go @PhysicalDeviceShaderDemoteToHelperInvocationFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TEXEL_BUFFER_ALIGNMENT_FEATURES_EXT -> go @PhysicalDeviceTexelBufferAlignmentFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_TEXEL_BUFFER_ALIGNMENT_PROPERTIES_EXT -> go @PhysicalDeviceTexelBufferAlignmentPropertiesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_FEATURES_EXT -> go @PhysicalDeviceSubgroupSizeControlFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_PROPERTIES_EXT -> go @PhysicalDeviceSubgroupSizeControlPropertiesEXT
  STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO_EXT -> go @PipelineShaderStageRequiredSubgroupSizeCreateInfoEXT
  STRUCTURE_TYPE_MEMORY_OPAQUE_CAPTURE_ADDRESS_ALLOCATE_INFO -> go @MemoryOpaqueCaptureAddressAllocateInfo
  STRUCTURE_TYPE_PHYSICAL_DEVICE_LINE_RASTERIZATION_FEATURES_EXT -> go @PhysicalDeviceLineRasterizationFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_LINE_RASTERIZATION_PROPERTIES_EXT -> go @PhysicalDeviceLineRasterizationPropertiesEXT
  STRUCTURE_TYPE_PIPELINE_RASTERIZATION_LINE_STATE_CREATE_INFO_EXT -> go @PipelineRasterizationLineStateCreateInfoEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_PIPELINE_CREATION_CACHE_CONTROL_FEATURES_EXT -> go @PhysicalDevicePipelineCreationCacheControlFeaturesEXT
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES -> go @PhysicalDeviceVulkan11Features
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_PROPERTIES -> go @PhysicalDeviceVulkan11Properties
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES -> go @PhysicalDeviceVulkan12Features
  STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_PROPERTIES -> go @PhysicalDeviceVulkan12Properties
  STRUCTURE_TYPE_PIPELINE_COMPILER_CONTROL_CREATE_INFO_AMD -> go @PipelineCompilerControlCreateInfoAMD
  STRUCTURE_TYPE_PHYSICAL_DEVICE_COHERENT_MEMORY_FEATURES_AMD -> go @PhysicalDeviceCoherentMemoryFeaturesAMD
  STRUCTURE_TYPE_DEFERRED_OPERATION_INFO_KHR -> go @DeferredOperationInfoKHR
  STRUCTURE_TYPE_RENDER_PASS_TRANSFORM_BEGIN_INFO_QCOM -> go @RenderPassTransformBeginInfoQCOM
  STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_RENDER_PASS_TRANSFORM_INFO_QCOM -> go @CommandBufferInheritanceRenderPassTransformInfoQCOM
  STRUCTURE_TYPE_PHYSICAL_DEVICE_DIAGNOSTICS_CONFIG_FEATURES_NV -> go @PhysicalDeviceDiagnosticsConfigFeaturesNV
  STRUCTURE_TYPE_DEVICE_DIAGNOSTICS_CONFIG_CREATE_INFO_NV -> go @DeviceDiagnosticsConfigCreateInfoNV
  t -> throwIO $ IOError Nothing InvalidArgument "peekChainHead" ("Unrecognized struct type: " <> show t) Nothing Nothing
 where
  go :: forall e . (Typeable e, FromCStruct e, ToCStruct e, Show e) => IO b
  go =
    let r = extends @a @e Proxy $ do
          head' <- peekCStruct @e (castPtr p)
          pure $ c head'
    in  fromMaybe
          (throwIO $ IOError
            Nothing
            InvalidArgument
            "peekChainHead"
            (  "Illegal struct extension of "
            <> show (extensibleType @a)
            <> " with "
            <> show ty
            )
            Nothing
            Nothing
          )
          r

class Extensible (a :: [Type] -> Type) where
  extensibleType :: StructureType
  getNext :: a es -> Chain es
  setNext :: a ds -> Chain es -> a es
  extends :: forall e b proxy. Typeable e => proxy e -> (Extends a e => b) -> Maybe b

type family Chain (xs :: [a]) = (r :: a) | r -> xs where
  Chain '[]    = ()
  Chain (x:xs) = (x, Chain xs)

-- | A pattern synonym to separate the head of a struct chain from the
-- tail, use in conjunction with ':&' to extract several members.
--
-- @
-- Head{..} ::& () <- returningNoTail a b c
-- -- Equivalent to
-- Head{..} <- returningNoTail @'[] a b c
-- @
--
-- @
-- Head{..} ::& Foo{..} :& Bar{..} :& () <- returningWithTail a b c
-- @
--
-- @
-- myFun (Head{..} :&& Foo{..} :& ())
-- @
pattern (::&) :: Extensible a => a es' -> Chain es -> a es
pattern a ::& es <- (\a -> (a, getNext a) -> (a, es))
  where a ::& es = setNext a es
infix 6 ::&

-- | View the head and tail of a 'Chain', see '::&'
--
-- Equivalent to @(,)@
pattern (:&) :: e -> Chain es -> Chain (e:es)
pattern e :& es = (e, es)
infixr 7 :&

type family Extendss (p :: [Type] -> Type) (xs :: [Type]) :: Constraint where
  Extendss p '[]      = ()
  Extendss p (x : xs) = (Extends p x, Extendss p xs)

class PokeChain es where
  withChain :: Chain es -> (Ptr (Chain es) -> IO a) -> IO a
  withZeroChain :: (Ptr (Chain es) -> IO a) -> IO a

instance PokeChain '[] where
  withChain () f = f nullPtr
  withZeroChain f = f nullPtr

instance (ToCStruct e, PokeChain es) => PokeChain (e:es) where
  withChain (e, es) f = evalContT $ do
    t <- ContT $ withChain es
    h <- ContT $ withCStruct e
    lift $ linkChain h t
    lift $ f (castPtr h)
  withZeroChain f = evalContT $ do
    t <- ContT $ withZeroChain @es
    h <- ContT $ withZeroCStruct @e
    lift $ linkChain h t
    lift $ f (castPtr h)

class PeekChain es where
  peekChain :: Ptr (Chain es) -> IO (Chain es)

instance PeekChain '[] where
  peekChain _ = pure ()

instance (FromCStruct e, PeekChain es) => PeekChain (e:es) where
  peekChain p = do
    h <- peekCStruct @e (castPtr p)
    tPtr <- peek (p `plusPtr` 8)
    t <- peekChain tPtr
    pure (h, t)

linkChain :: Ptr a -> Ptr b -> IO ()
linkChain head' tail' = poke (head' `plusPtr` 8) tail'

