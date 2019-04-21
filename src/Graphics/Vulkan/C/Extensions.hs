{-# language Strict #-}
{-# language CPP #-}


module Graphics.Vulkan.C.Extensions
  ( module Graphics.Vulkan.C.Extensions.VK_KHR_surface
  , module Graphics.Vulkan.C.Extensions.VK_KHR_swapchain
  , module Graphics.Vulkan.C.Extensions.VK_KHR_display
  , module Graphics.Vulkan.C.Extensions.VK_KHR_display_swapchain
#if VK_USE_PLATFORM_XLIB_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_xlib_surface
#endif
#if VK_USE_PLATFORM_XCB_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_xcb_surface
#endif
#if VK_USE_PLATFORM_WAYLAND_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_wayland_surface
#endif
#if VK_USE_PLATFORM_ANDROID_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_android_surface
#endif
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_win32_surface
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_debug_report
  , module Graphics.Vulkan.C.Extensions.VK_NV_glsl_shader
  , module Graphics.Vulkan.C.Extensions.VK_EXT_depth_range_unrestricted
  , module Graphics.Vulkan.C.Extensions.VK_KHR_sampler_mirror_clamp_to_edge
  , module Graphics.Vulkan.C.Extensions.VK_IMG_filter_cubic
  , module Graphics.Vulkan.C.Extensions.VK_AMD_rasterization_order
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_trinary_minmax
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_explicit_vertex_parameter
  , module Graphics.Vulkan.C.Extensions.VK_EXT_debug_marker
  , module Graphics.Vulkan.C.Extensions.VK_AMD_gcn_shader
  , module Graphics.Vulkan.C.Extensions.VK_NV_dedicated_allocation
  , module Graphics.Vulkan.C.Extensions.VK_EXT_transform_feedback
  , module Graphics.Vulkan.C.Extensions.VK_NVX_image_view_handle
  , module Graphics.Vulkan.C.Extensions.VK_AMD_draw_indirect_count
  , module Graphics.Vulkan.C.Extensions.VK_AMD_negative_viewport_height
  , module Graphics.Vulkan.C.Extensions.VK_AMD_gpu_shader_half_float
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_ballot
  , module Graphics.Vulkan.C.Extensions.VK_AMD_texture_gather_bias_lod
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_info
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_image_load_store_lod
#if VK_USE_PLATFORM_GGP
  , module Graphics.Vulkan.C.Extensions.VK_GGP_stream_descriptor_surface
#endif
  , module Graphics.Vulkan.C.Extensions.VK_NV_corner_sampled_image
  , module Graphics.Vulkan.C.Extensions.VK_KHR_multiview
  , module Graphics.Vulkan.C.Extensions.VK_IMG_format_pvrtc
  , module Graphics.Vulkan.C.Extensions.VK_NV_external_memory_capabilities
  , module Graphics.Vulkan.C.Extensions.VK_NV_external_memory
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_NV_external_memory_win32
  , module Graphics.Vulkan.C.Extensions.VK_NV_win32_keyed_mutex
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_get_physical_device_properties2
  , module Graphics.Vulkan.C.Extensions.VK_KHR_device_group
  , module Graphics.Vulkan.C.Extensions.VK_EXT_validation_flags
#if VK_USE_PLATFORM_VI_NN
  , module Graphics.Vulkan.C.Extensions.VK_NN_vi_surface
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_shader_draw_parameters
  , module Graphics.Vulkan.C.Extensions.VK_EXT_shader_subgroup_ballot
  , module Graphics.Vulkan.C.Extensions.VK_EXT_shader_subgroup_vote
  , module Graphics.Vulkan.C.Extensions.VK_EXT_astc_decode_mode
  , module Graphics.Vulkan.C.Extensions.VK_KHR_maintenance1
  , module Graphics.Vulkan.C.Extensions.VK_KHR_device_group_creation
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_capabilities
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_memory
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_win32
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_fd
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_win32_keyed_mutex
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_capabilities
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_win32
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_fd
  , module Graphics.Vulkan.C.Extensions.VK_KHR_push_descriptor
  , module Graphics.Vulkan.C.Extensions.VK_EXT_conditional_rendering
  , module Graphics.Vulkan.C.Extensions.VK_KHR_shader_float16_int8
  , module Graphics.Vulkan.C.Extensions.VK_KHR_16bit_storage
  , module Graphics.Vulkan.C.Extensions.VK_KHR_incremental_present
  , module Graphics.Vulkan.C.Extensions.VK_KHR_descriptor_update_template
  , module Graphics.Vulkan.C.Extensions.VK_NVX_device_generated_commands
  , module Graphics.Vulkan.C.Extensions.VK_NV_clip_space_w_scaling
  , module Graphics.Vulkan.C.Extensions.VK_EXT_direct_mode_display
#if VK_USE_PLATFORM_XLIB_XRANDR_EXT
  , module Graphics.Vulkan.C.Extensions.VK_EXT_acquire_xlib_display
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_display_surface_counter
  , module Graphics.Vulkan.C.Extensions.VK_EXT_display_control
  , module Graphics.Vulkan.C.Extensions.VK_GOOGLE_display_timing
  , module Graphics.Vulkan.C.Extensions.VK_NV_sample_mask_override_coverage
  , module Graphics.Vulkan.C.Extensions.VK_NV_geometry_shader_passthrough
  , module Graphics.Vulkan.C.Extensions.VK_NV_viewport_array2
  , module Graphics.Vulkan.C.Extensions.VK_NVX_multiview_per_view_attributes
  , module Graphics.Vulkan.C.Extensions.VK_NV_viewport_swizzle
  , module Graphics.Vulkan.C.Extensions.VK_EXT_discard_rectangles
  , module Graphics.Vulkan.C.Extensions.VK_EXT_conservative_rasterization
  , module Graphics.Vulkan.C.Extensions.VK_EXT_depth_clip_enable
  , module Graphics.Vulkan.C.Extensions.VK_EXT_swapchain_colorspace
  , module Graphics.Vulkan.C.Extensions.VK_EXT_hdr_metadata
  , module Graphics.Vulkan.C.Extensions.VK_KHR_create_renderpass2
  , module Graphics.Vulkan.C.Extensions.VK_KHR_shared_presentable_image
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_capabilities
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_fence
#if VK_USE_PLATFORM_WIN32_KHR
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_win32
#endif
  , module Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_fd
  , module Graphics.Vulkan.C.Extensions.VK_KHR_maintenance2
  , module Graphics.Vulkan.C.Extensions.VK_KHR_get_surface_capabilities2
  , module Graphics.Vulkan.C.Extensions.VK_KHR_variable_pointers
  , module Graphics.Vulkan.C.Extensions.VK_KHR_get_display_properties2
#if VK_USE_PLATFORM_IOS_MVK
  , module Graphics.Vulkan.C.Extensions.VK_MVK_ios_surface
#endif
#if VK_USE_PLATFORM_MACOS_MVK
  , module Graphics.Vulkan.C.Extensions.VK_MVK_macos_surface
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_external_memory_dma_buf
  , module Graphics.Vulkan.C.Extensions.VK_EXT_queue_family_foreign
  , module Graphics.Vulkan.C.Extensions.VK_KHR_dedicated_allocation
  , module Graphics.Vulkan.C.Extensions.VK_EXT_debug_utils
#if VK_USE_PLATFORM_ANDROID_KHR
  , module Graphics.Vulkan.C.Extensions.VK_ANDROID_external_memory_android_hardware_buffer
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_sampler_filter_minmax
  , module Graphics.Vulkan.C.Extensions.VK_KHR_storage_buffer_storage_class
  , module Graphics.Vulkan.C.Extensions.VK_AMD_gpu_shader_int16
  , module Graphics.Vulkan.C.Extensions.VK_AMD_mixed_attachment_samples
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_fragment_mask
  , module Graphics.Vulkan.C.Extensions.VK_EXT_inline_uniform_block
  , module Graphics.Vulkan.C.Extensions.VK_EXT_shader_stencil_export
  , module Graphics.Vulkan.C.Extensions.VK_EXT_sample_locations
  , module Graphics.Vulkan.C.Extensions.VK_KHR_relaxed_block_layout
  , module Graphics.Vulkan.C.Extensions.VK_KHR_get_memory_requirements2
  , module Graphics.Vulkan.C.Extensions.VK_KHR_image_format_list
  , module Graphics.Vulkan.C.Extensions.VK_EXT_blend_operation_advanced
  , module Graphics.Vulkan.C.Extensions.VK_NV_fragment_coverage_to_color
  , module Graphics.Vulkan.C.Extensions.VK_NV_framebuffer_mixed_samples
  , module Graphics.Vulkan.C.Extensions.VK_NV_fill_rectangle
  , module Graphics.Vulkan.C.Extensions.VK_EXT_post_depth_coverage
  , module Graphics.Vulkan.C.Extensions.VK_KHR_sampler_ycbcr_conversion
  , module Graphics.Vulkan.C.Extensions.VK_KHR_bind_memory2
  , module Graphics.Vulkan.C.Extensions.VK_EXT_image_drm_format_modifier
  , module Graphics.Vulkan.C.Extensions.VK_EXT_validation_cache
  , module Graphics.Vulkan.C.Extensions.VK_EXT_descriptor_indexing
  , module Graphics.Vulkan.C.Extensions.VK_EXT_shader_viewport_index_layer
  , module Graphics.Vulkan.C.Extensions.VK_NV_shading_rate_image
  , module Graphics.Vulkan.C.Extensions.VK_NV_ray_tracing
  , module Graphics.Vulkan.C.Extensions.VK_NV_representative_fragment_test
  , module Graphics.Vulkan.C.Extensions.VK_KHR_maintenance3
  , module Graphics.Vulkan.C.Extensions.VK_KHR_draw_indirect_count
  , module Graphics.Vulkan.C.Extensions.VK_EXT_filter_cubic
  , module Graphics.Vulkan.C.Extensions.VK_EXT_global_priority
  , module Graphics.Vulkan.C.Extensions.VK_KHR_8bit_storage
  , module Graphics.Vulkan.C.Extensions.VK_EXT_external_memory_host
  , module Graphics.Vulkan.C.Extensions.VK_AMD_buffer_marker
  , module Graphics.Vulkan.C.Extensions.VK_KHR_shader_atomic_int64
  , module Graphics.Vulkan.C.Extensions.VK_EXT_calibrated_timestamps
  , module Graphics.Vulkan.C.Extensions.VK_AMD_shader_core_properties
  , module Graphics.Vulkan.C.Extensions.VK_AMD_memory_overallocation_behavior
  , module Graphics.Vulkan.C.Extensions.VK_EXT_vertex_attribute_divisor
#if VK_USE_PLATFORM_GGP
  , module Graphics.Vulkan.C.Extensions.VK_GGP_frame_token
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_pipeline_creation_feedback
  , module Graphics.Vulkan.C.Extensions.VK_KHR_driver_properties
  , module Graphics.Vulkan.C.Extensions.VK_KHR_shader_float_controls
  , module Graphics.Vulkan.C.Extensions.VK_NV_shader_subgroup_partitioned
  , module Graphics.Vulkan.C.Extensions.VK_KHR_depth_stencil_resolve
  , module Graphics.Vulkan.C.Extensions.VK_KHR_swapchain_mutable_format
  , module Graphics.Vulkan.C.Extensions.VK_NV_compute_shader_derivatives
  , module Graphics.Vulkan.C.Extensions.VK_NV_mesh_shader
  , module Graphics.Vulkan.C.Extensions.VK_NV_fragment_shader_barycentric
  , module Graphics.Vulkan.C.Extensions.VK_NV_shader_image_footprint
  , module Graphics.Vulkan.C.Extensions.VK_NV_scissor_exclusive
  , module Graphics.Vulkan.C.Extensions.VK_NV_device_diagnostic_checkpoints
  , module Graphics.Vulkan.C.Extensions.VK_KHR_vulkan_memory_model
  , module Graphics.Vulkan.C.Extensions.VK_EXT_pci_bus_info
  , module Graphics.Vulkan.C.Extensions.VK_AMD_display_native_hdr
#if VK_USE_PLATFORM_FUCHSIA
  , module Graphics.Vulkan.C.Extensions.VK_FUCHSIA_imagepipe_surface
#endif
#if VK_USE_PLATFORM_METAL_EXT
  , module Graphics.Vulkan.C.Extensions.VK_EXT_metal_surface
#endif
  , module Graphics.Vulkan.C.Extensions.VK_EXT_fragment_density_map
  , module Graphics.Vulkan.C.Extensions.VK_EXT_scalar_block_layout
  , module Graphics.Vulkan.C.Extensions.VK_GOOGLE_hlsl_functionality1
  , module Graphics.Vulkan.C.Extensions.VK_GOOGLE_decorate_string
  , module Graphics.Vulkan.C.Extensions.VK_EXT_memory_budget
  , module Graphics.Vulkan.C.Extensions.VK_EXT_memory_priority
  , module Graphics.Vulkan.C.Extensions.VK_KHR_surface_protected_capabilities
  , module Graphics.Vulkan.C.Extensions.VK_NV_dedicated_allocation_image_aliasing
  , module Graphics.Vulkan.C.Extensions.VK_EXT_buffer_device_address
  , module Graphics.Vulkan.C.Extensions.VK_EXT_separate_stencil_usage
  , module Graphics.Vulkan.C.Extensions.VK_EXT_validation_features
  , module Graphics.Vulkan.C.Extensions.VK_NV_cooperative_matrix
  , module Graphics.Vulkan.C.Extensions.VK_EXT_ycbcr_image_arrays
  , module Graphics.Vulkan.C.Extensions.VK_EXT_full_screen_exclusive
  , module Graphics.Vulkan.C.Extensions.VK_EXT_headless_surface
  , module Graphics.Vulkan.C.Extensions.VK_EXT_host_query_reset
  ) where


import Graphics.Vulkan.C.Extensions.VK_KHR_surface
import Graphics.Vulkan.C.Extensions.VK_KHR_swapchain
import Graphics.Vulkan.C.Extensions.VK_KHR_display
import Graphics.Vulkan.C.Extensions.VK_KHR_display_swapchain
#if VK_USE_PLATFORM_XLIB_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_xlib_surface
#endif
#if VK_USE_PLATFORM_XCB_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_xcb_surface
#endif
#if VK_USE_PLATFORM_WAYLAND_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_wayland_surface
#endif
#if VK_USE_PLATFORM_ANDROID_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_android_surface
#endif
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_win32_surface
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_debug_report
import Graphics.Vulkan.C.Extensions.VK_NV_glsl_shader
import Graphics.Vulkan.C.Extensions.VK_EXT_depth_range_unrestricted
import Graphics.Vulkan.C.Extensions.VK_KHR_sampler_mirror_clamp_to_edge
import Graphics.Vulkan.C.Extensions.VK_IMG_filter_cubic
import Graphics.Vulkan.C.Extensions.VK_AMD_rasterization_order
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_trinary_minmax
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_explicit_vertex_parameter
import Graphics.Vulkan.C.Extensions.VK_EXT_debug_marker
import Graphics.Vulkan.C.Extensions.VK_AMD_gcn_shader
import Graphics.Vulkan.C.Extensions.VK_NV_dedicated_allocation
import Graphics.Vulkan.C.Extensions.VK_EXT_transform_feedback
import Graphics.Vulkan.C.Extensions.VK_NVX_image_view_handle
import Graphics.Vulkan.C.Extensions.VK_AMD_draw_indirect_count
import Graphics.Vulkan.C.Extensions.VK_AMD_negative_viewport_height
import Graphics.Vulkan.C.Extensions.VK_AMD_gpu_shader_half_float
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_ballot
import Graphics.Vulkan.C.Extensions.VK_AMD_texture_gather_bias_lod
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_info
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_image_load_store_lod
#if VK_USE_PLATFORM_GGP
import Graphics.Vulkan.C.Extensions.VK_GGP_stream_descriptor_surface
#endif
import Graphics.Vulkan.C.Extensions.VK_NV_corner_sampled_image
import Graphics.Vulkan.C.Extensions.VK_KHR_multiview
import Graphics.Vulkan.C.Extensions.VK_IMG_format_pvrtc
import Graphics.Vulkan.C.Extensions.VK_NV_external_memory_capabilities
import Graphics.Vulkan.C.Extensions.VK_NV_external_memory
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_NV_external_memory_win32
#endif
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_NV_win32_keyed_mutex
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_get_physical_device_properties2
import Graphics.Vulkan.C.Extensions.VK_KHR_device_group
import Graphics.Vulkan.C.Extensions.VK_EXT_validation_flags
#if VK_USE_PLATFORM_VI_NN
import Graphics.Vulkan.C.Extensions.VK_NN_vi_surface
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_shader_draw_parameters
import Graphics.Vulkan.C.Extensions.VK_EXT_shader_subgroup_ballot
import Graphics.Vulkan.C.Extensions.VK_EXT_shader_subgroup_vote
import Graphics.Vulkan.C.Extensions.VK_EXT_astc_decode_mode
import Graphics.Vulkan.C.Extensions.VK_KHR_maintenance1
import Graphics.Vulkan.C.Extensions.VK_KHR_device_group_creation
import Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_capabilities
import Graphics.Vulkan.C.Extensions.VK_KHR_external_memory
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_win32
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_external_memory_fd
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_win32_keyed_mutex
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_capabilities
import Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_win32
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_external_semaphore_fd
import Graphics.Vulkan.C.Extensions.VK_KHR_push_descriptor
import Graphics.Vulkan.C.Extensions.VK_EXT_conditional_rendering
import Graphics.Vulkan.C.Extensions.VK_KHR_shader_float16_int8
import Graphics.Vulkan.C.Extensions.VK_KHR_16bit_storage
import Graphics.Vulkan.C.Extensions.VK_KHR_incremental_present
import Graphics.Vulkan.C.Extensions.VK_KHR_descriptor_update_template
import Graphics.Vulkan.C.Extensions.VK_NVX_device_generated_commands
import Graphics.Vulkan.C.Extensions.VK_NV_clip_space_w_scaling
import Graphics.Vulkan.C.Extensions.VK_EXT_direct_mode_display
#if VK_USE_PLATFORM_XLIB_XRANDR_EXT
import Graphics.Vulkan.C.Extensions.VK_EXT_acquire_xlib_display
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_display_surface_counter
import Graphics.Vulkan.C.Extensions.VK_EXT_display_control
import Graphics.Vulkan.C.Extensions.VK_GOOGLE_display_timing
import Graphics.Vulkan.C.Extensions.VK_NV_sample_mask_override_coverage
import Graphics.Vulkan.C.Extensions.VK_NV_geometry_shader_passthrough
import Graphics.Vulkan.C.Extensions.VK_NV_viewport_array2
import Graphics.Vulkan.C.Extensions.VK_NVX_multiview_per_view_attributes
import Graphics.Vulkan.C.Extensions.VK_NV_viewport_swizzle
import Graphics.Vulkan.C.Extensions.VK_EXT_discard_rectangles
import Graphics.Vulkan.C.Extensions.VK_EXT_conservative_rasterization
import Graphics.Vulkan.C.Extensions.VK_EXT_depth_clip_enable
import Graphics.Vulkan.C.Extensions.VK_EXT_swapchain_colorspace
import Graphics.Vulkan.C.Extensions.VK_EXT_hdr_metadata
import Graphics.Vulkan.C.Extensions.VK_KHR_create_renderpass2
import Graphics.Vulkan.C.Extensions.VK_KHR_shared_presentable_image
import Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_capabilities
import Graphics.Vulkan.C.Extensions.VK_KHR_external_fence
#if VK_USE_PLATFORM_WIN32_KHR
import Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_win32
#endif
import Graphics.Vulkan.C.Extensions.VK_KHR_external_fence_fd
import Graphics.Vulkan.C.Extensions.VK_KHR_maintenance2
import Graphics.Vulkan.C.Extensions.VK_KHR_get_surface_capabilities2
import Graphics.Vulkan.C.Extensions.VK_KHR_variable_pointers
import Graphics.Vulkan.C.Extensions.VK_KHR_get_display_properties2
#if VK_USE_PLATFORM_IOS_MVK
import Graphics.Vulkan.C.Extensions.VK_MVK_ios_surface
#endif
#if VK_USE_PLATFORM_MACOS_MVK
import Graphics.Vulkan.C.Extensions.VK_MVK_macos_surface
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_external_memory_dma_buf
import Graphics.Vulkan.C.Extensions.VK_EXT_queue_family_foreign
import Graphics.Vulkan.C.Extensions.VK_KHR_dedicated_allocation
import Graphics.Vulkan.C.Extensions.VK_EXT_debug_utils
#if VK_USE_PLATFORM_ANDROID_KHR
import Graphics.Vulkan.C.Extensions.VK_ANDROID_external_memory_android_hardware_buffer
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_sampler_filter_minmax
import Graphics.Vulkan.C.Extensions.VK_KHR_storage_buffer_storage_class
import Graphics.Vulkan.C.Extensions.VK_AMD_gpu_shader_int16
import Graphics.Vulkan.C.Extensions.VK_AMD_mixed_attachment_samples
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_fragment_mask
import Graphics.Vulkan.C.Extensions.VK_EXT_inline_uniform_block
import Graphics.Vulkan.C.Extensions.VK_EXT_shader_stencil_export
import Graphics.Vulkan.C.Extensions.VK_EXT_sample_locations
import Graphics.Vulkan.C.Extensions.VK_KHR_relaxed_block_layout
import Graphics.Vulkan.C.Extensions.VK_KHR_get_memory_requirements2
import Graphics.Vulkan.C.Extensions.VK_KHR_image_format_list
import Graphics.Vulkan.C.Extensions.VK_EXT_blend_operation_advanced
import Graphics.Vulkan.C.Extensions.VK_NV_fragment_coverage_to_color
import Graphics.Vulkan.C.Extensions.VK_NV_framebuffer_mixed_samples
import Graphics.Vulkan.C.Extensions.VK_NV_fill_rectangle
import Graphics.Vulkan.C.Extensions.VK_EXT_post_depth_coverage
import Graphics.Vulkan.C.Extensions.VK_KHR_sampler_ycbcr_conversion
import Graphics.Vulkan.C.Extensions.VK_KHR_bind_memory2
import Graphics.Vulkan.C.Extensions.VK_EXT_image_drm_format_modifier
import Graphics.Vulkan.C.Extensions.VK_EXT_validation_cache
import Graphics.Vulkan.C.Extensions.VK_EXT_descriptor_indexing
import Graphics.Vulkan.C.Extensions.VK_EXT_shader_viewport_index_layer
import Graphics.Vulkan.C.Extensions.VK_NV_shading_rate_image
import Graphics.Vulkan.C.Extensions.VK_NV_ray_tracing
import Graphics.Vulkan.C.Extensions.VK_NV_representative_fragment_test
import Graphics.Vulkan.C.Extensions.VK_KHR_maintenance3
import Graphics.Vulkan.C.Extensions.VK_KHR_draw_indirect_count
import Graphics.Vulkan.C.Extensions.VK_EXT_filter_cubic
import Graphics.Vulkan.C.Extensions.VK_EXT_global_priority
import Graphics.Vulkan.C.Extensions.VK_KHR_8bit_storage
import Graphics.Vulkan.C.Extensions.VK_EXT_external_memory_host
import Graphics.Vulkan.C.Extensions.VK_AMD_buffer_marker
import Graphics.Vulkan.C.Extensions.VK_KHR_shader_atomic_int64
import Graphics.Vulkan.C.Extensions.VK_EXT_calibrated_timestamps
import Graphics.Vulkan.C.Extensions.VK_AMD_shader_core_properties
import Graphics.Vulkan.C.Extensions.VK_AMD_memory_overallocation_behavior
import Graphics.Vulkan.C.Extensions.VK_EXT_vertex_attribute_divisor
#if VK_USE_PLATFORM_GGP
import Graphics.Vulkan.C.Extensions.VK_GGP_frame_token
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_pipeline_creation_feedback
import Graphics.Vulkan.C.Extensions.VK_KHR_driver_properties
import Graphics.Vulkan.C.Extensions.VK_KHR_shader_float_controls
import Graphics.Vulkan.C.Extensions.VK_NV_shader_subgroup_partitioned
import Graphics.Vulkan.C.Extensions.VK_KHR_depth_stencil_resolve
import Graphics.Vulkan.C.Extensions.VK_KHR_swapchain_mutable_format
import Graphics.Vulkan.C.Extensions.VK_NV_compute_shader_derivatives
import Graphics.Vulkan.C.Extensions.VK_NV_mesh_shader
import Graphics.Vulkan.C.Extensions.VK_NV_fragment_shader_barycentric
import Graphics.Vulkan.C.Extensions.VK_NV_shader_image_footprint
import Graphics.Vulkan.C.Extensions.VK_NV_scissor_exclusive
import Graphics.Vulkan.C.Extensions.VK_NV_device_diagnostic_checkpoints
import Graphics.Vulkan.C.Extensions.VK_KHR_vulkan_memory_model
import Graphics.Vulkan.C.Extensions.VK_EXT_pci_bus_info
import Graphics.Vulkan.C.Extensions.VK_AMD_display_native_hdr
#if VK_USE_PLATFORM_FUCHSIA
import Graphics.Vulkan.C.Extensions.VK_FUCHSIA_imagepipe_surface
#endif
#if VK_USE_PLATFORM_METAL_EXT
import Graphics.Vulkan.C.Extensions.VK_EXT_metal_surface
#endif
import Graphics.Vulkan.C.Extensions.VK_EXT_fragment_density_map
import Graphics.Vulkan.C.Extensions.VK_EXT_scalar_block_layout
import Graphics.Vulkan.C.Extensions.VK_GOOGLE_hlsl_functionality1
import Graphics.Vulkan.C.Extensions.VK_GOOGLE_decorate_string
import Graphics.Vulkan.C.Extensions.VK_EXT_memory_budget
import Graphics.Vulkan.C.Extensions.VK_EXT_memory_priority
import Graphics.Vulkan.C.Extensions.VK_KHR_surface_protected_capabilities
import Graphics.Vulkan.C.Extensions.VK_NV_dedicated_allocation_image_aliasing
import Graphics.Vulkan.C.Extensions.VK_EXT_buffer_device_address
import Graphics.Vulkan.C.Extensions.VK_EXT_separate_stencil_usage
import Graphics.Vulkan.C.Extensions.VK_EXT_validation_features
import Graphics.Vulkan.C.Extensions.VK_NV_cooperative_matrix
import Graphics.Vulkan.C.Extensions.VK_EXT_ycbcr_image_arrays
import Graphics.Vulkan.C.Extensions.VK_EXT_full_screen_exclusive
import Graphics.Vulkan.C.Extensions.VK_EXT_headless_surface
import Graphics.Vulkan.C.Extensions.VK_EXT_host_query_reset



