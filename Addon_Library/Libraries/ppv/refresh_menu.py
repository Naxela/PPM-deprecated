import bpy

class ArmRenderPathRendererPanel(bpy.types.Panel):
    bl_label = "Renderer"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.prop(rpdat, 'rp_renderer')
        if rpdat.rp_renderer == 'Forward':
            layout.prop(rpdat, 'rp_depthprepass')
        layout.prop(rpdat, 'arm_material_model')
        layout.prop(rpdat, 'rp_translucency_state')
        layout.prop(rpdat, 'rp_overlays_state')
        layout.prop(rpdat, 'rp_decals_state')
        layout.prop(rpdat, 'rp_blending_state')
        layout.prop(rpdat, 'rp_draw_order')
        layout.prop(rpdat, 'arm_samples_per_pixel')
        layout.prop(rpdat, 'arm_texture_filter')
        layout.prop(rpdat, 'rp_sss_state')
        col = layout.column()
        col.enabled = rpdat.rp_sss_state != 'Off'
        col.prop(rpdat, 'arm_sss_width')
        layout.prop(rpdat, 'arm_rp_displacement')
        if rpdat.arm_rp_displacement == 'Tessellation':
            layout.label(text='Mesh')
            layout.prop(rpdat, 'arm_tess_mesh_inner')
            layout.prop(rpdat, 'arm_tess_mesh_outer')
            layout.label(text='Shadow')
            layout.prop(rpdat, 'arm_tess_shadows_inner')
            layout.prop(rpdat, 'arm_tess_shadows_outer')  

        layout.prop(rpdat, 'arm_particles')
        layout.prop(rpdat, 'arm_skin')
        row = layout.row()
        row.enabled = rpdat.arm_skin.startswith('GPU')
        row.prop(rpdat, 'arm_skin_max_bones_auto')
        row = layout.row()
        row.enabled = not rpdat.arm_skin_max_bones_auto
        row.prop(rpdat, 'arm_skin_max_bones')
        layout.prop(rpdat, "rp_hdr")
        layout.prop(rpdat, "rp_stereo")
        layout.prop(rpdat, 'arm_culling')
        layout.prop(wrd, 'arm_ppv')

class ArmRenderPathShadowsPanel(bpy.types.Panel):
    bl_label = "Shadows"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw_header(self, context):
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]
        self.layout.prop(rpdat, "rp_shadows", text="")

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.enabled = rpdat.rp_shadows
        layout.prop(rpdat, 'rp_shadowmap_cube')
        layout.prop(rpdat, 'rp_shadowmap_cascade')
        layout.prop(rpdat, 'rp_shadowmap_cascades')
        col = layout.column()
        col2 = col.column()
        col2.enabled = rpdat.rp_shadowmap_cascades != '1'
        col2.prop(rpdat, 'arm_shadowmap_split')
        col.prop(rpdat, 'arm_shadowmap_bounds')
        # col.prop(rpdat, 'arm_soft_shadows')
        # col2 = col.column()
        # col2.enabled = rpdat.arm_soft_shadows != 'Off'
        # col2.prop(rpdat, 'arm_soft_shadows_penumbra')
        # col2.prop(rpdat, 'arm_soft_shadows_distance')
        col.prop(rpdat, 'arm_pcfsize')

class ArmRenderPathVoxelsPanel(bpy.types.Panel):
    bl_label = "Voxels"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.prop(rpdat, 'rp_gi')
        col = layout.column()
        col.enabled = rpdat.rp_gi != 'Off'
        col2 = col.column()
        col2.enabled = rpdat.rp_gi == 'Voxel GI'
        # col2.prop(rpdat, 'arm_voxelgi_bounces')
        col2.prop(rpdat, 'rp_voxelgi_relight')
        col3 = col.column()
        col3.enabled = rpdat.rp_gi == 'Voxel AO'
        col3.prop(rpdat, 'arm_voxelgi_shadows')
        col.prop(rpdat, 'arm_voxelgi_cones')
        col.prop(rpdat, 'rp_voxelgi_resolution')
        col.prop(rpdat, 'rp_voxelgi_resolution_z')
        col.prop(rpdat, 'arm_voxelgi_dimensions')
        col.prop(rpdat, 'arm_voxelgi_revoxelize')
        col2 = col.column()
        col2.enabled = rpdat.arm_voxelgi_revoxelize
        col2.prop(rpdat, 'arm_voxelgi_camera')
        col2.prop(rpdat, 'arm_voxelgi_temporal')
        col.label(text="Light")
        col2 = col.column()
        col2.enabled = rpdat.rp_gi == 'Voxel GI'
        col2.prop(rpdat, 'arm_voxelgi_diff')
        col2.prop(rpdat, 'arm_voxelgi_spec')
        col.prop(rpdat, 'arm_voxelgi_occ')
        col.prop(rpdat, 'arm_voxelgi_env')
        col.label(text="Ray")
        col.prop(rpdat, 'arm_voxelgi_step')
        col.prop(rpdat, 'arm_voxelgi_range')
        col.prop(rpdat, 'arm_voxelgi_offset')

class ArmRenderPathWorldPanel(bpy.types.Panel):
    bl_label = "World"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.prop(rpdat, "rp_background")
        layout.prop(rpdat, 'arm_irradiance')
        col = layout.column()
        col.enabled = rpdat.arm_irradiance
        col.prop(rpdat, 'arm_radiance')
        colb = col.column()
        colb.enabled = rpdat.arm_radiance
        colb.prop(rpdat, 'arm_radiance_size')
        layout.prop(rpdat, 'arm_clouds')
        col = layout.column()
        col.enabled = rpdat.arm_clouds
        col.prop(rpdat, 'arm_clouds_density')
        col.prop(rpdat, 'arm_clouds_size')
        col.prop(rpdat, 'arm_clouds_lower')
        col.prop(rpdat, 'arm_clouds_upper')
        col.prop(rpdat, 'arm_clouds_precipitation')
        col.prop(rpdat, 'arm_clouds_eccentricity')
        col.prop(rpdat, 'arm_clouds_secondary')
        col.prop(rpdat, 'arm_clouds_wind')
        layout.prop(rpdat, "rp_ocean")
        col = layout.column()
        col.enabled = rpdat.rp_ocean
        col.prop(rpdat, 'arm_ocean_level')
        col.prop(rpdat, 'arm_ocean_fade')
        col.prop(rpdat, 'arm_ocean_amplitude')
        col.prop(rpdat, 'arm_ocean_height')
        col.prop(rpdat, 'arm_ocean_choppy')
        col.prop(rpdat, 'arm_ocean_speed')
        col.prop(rpdat, 'arm_ocean_freq')
        col.prop(rpdat, 'arm_ocean_base_color')
        col.prop(rpdat, 'arm_ocean_water_color')

class ArmRenderPathPostProcessPanel(bpy.types.Panel):
    bl_label = "Post Process"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw_header(self, context):
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]
        self.layout.prop(rpdat, "rp_render_to_texture", text="")

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.enabled = rpdat.rp_render_to_texture
        row = layout.row()
        row.prop(rpdat, "rp_antialiasing")
        layout.prop(rpdat, "rp_supersampling")
        layout.prop(rpdat, 'arm_rp_resolution')
        if rpdat.arm_rp_resolution == 'Custom':
            layout.prop(rpdat, 'arm_rp_resolution_size')
            layout.prop(rpdat, 'arm_rp_resolution_filter')
        layout.prop(rpdat, 'rp_dynres')
        layout.separator()
        row = layout.row()
        row.prop(rpdat, "rp_ssgi")
        col = layout.column()
        col.enabled = rpdat.rp_ssgi != 'Off'
        col.prop(rpdat, 'arm_ssgi_half_res')
        col.prop(rpdat, 'arm_ssgi_rays')
        col.prop(rpdat, 'arm_ssgi_radius')
        col.prop(rpdat, 'arm_ssgi_strength')
        col.prop(rpdat, 'arm_ssgi_max_steps')
        layout.separator()
        layout.prop(rpdat, "rp_ssr")
        col = layout.column()
        col.enabled = rpdat.rp_ssr
        col.prop(rpdat, 'arm_ssr_half_res')
        col.prop(rpdat, 'arm_ssr_ray_step')
        col.prop(rpdat, 'arm_ssr_min_ray_step')
        col.prop(rpdat, 'arm_ssr_search_dist')
        col.prop(rpdat, 'arm_ssr_falloff_exp')
        col.prop(rpdat, 'arm_ssr_jitter')
        layout.separator()
        layout.prop(rpdat, 'arm_ssrs')
        col = layout.column()
        col.enabled = rpdat.arm_ssrs
        col.prop(rpdat, 'arm_ssrs_ray_step')
        layout.separator()
        layout.prop(rpdat, "rp_bloom")
        col = layout.column()
        col.enabled = rpdat.rp_bloom
        col.prop(rpdat, 'arm_bloom_threshold')
        col.prop(rpdat, 'arm_bloom_strength')
        col.prop(rpdat, 'arm_bloom_radius')
        layout.separator()
        layout.prop(rpdat, "rp_motionblur")
        col = layout.column()
        col.enabled = rpdat.rp_motionblur != 'Off'
        col.prop(rpdat, 'arm_motion_blur_intensity')
        layout.separator()
        layout.prop(rpdat, "rp_volumetriclight")
        col = layout.column()
        col.enabled = rpdat.rp_volumetriclight
        col.prop(rpdat, 'arm_volumetric_light_air_color')
        col.prop(rpdat, 'arm_volumetric_light_air_turbidity')
        col.prop(rpdat, 'arm_volumetric_light_steps')

class ArmRenderPathCompositorPanel(bpy.types.Panel):
    bl_label = "Compositor"
    bl_space_type = "PROPERTIES"
    bl_region_type = "WINDOW"
    bl_context = "render"
    bl_options = {'DEFAULT_CLOSED'}
    bl_parent_id = "ArmRenderPathPanel"

    def draw_header(self, context):
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]
        self.layout.prop(rpdat, "rp_compositornodes", text="")

    def draw(self, context):
        layout = self.layout
        layout.use_property_split = True
        layout.use_property_decorate = False
        wrd = bpy.data.worlds['Arm']
        if len(wrd.arm_rplist) <= wrd.arm_rplist_index:
            return
        rpdat = wrd.arm_rplist[wrd.arm_rplist_index]

        layout.enabled = rpdat.rp_compositornodes
        layout.prop(rpdat, 'arm_tonemap')
        layout.prop(rpdat, 'arm_letterbox')
        col = layout.column()
        col.enabled = rpdat.arm_letterbox
        col.prop(rpdat, 'arm_letterbox_size')
        layout.prop(rpdat, 'arm_sharpen')
        col = layout.column()
        col.enabled = rpdat.arm_sharpen
        col.prop(rpdat, 'arm_sharpen_strength')
        layout.prop(rpdat, 'arm_fisheye')
        layout.prop(rpdat, 'arm_vignette')
        layout.prop(rpdat, 'arm_lensflare')
        layout.prop(rpdat, 'arm_grain')
        col = layout.column()
        col.enabled = rpdat.arm_grain
        col.prop(rpdat, 'arm_grain_strength')
        layout.prop(rpdat, 'arm_fog')
        col = layout.column()
        col.enabled = rpdat.arm_fog
        col.prop(rpdat, 'arm_fog_color')
        col.prop(rpdat, 'arm_fog_amounta')
        col.prop(rpdat, 'arm_fog_amountb')
        layout.separator()
        layout.prop(rpdat, "rp_autoexposure")
        col = layout.column()
        col.enabled = rpdat.rp_autoexposure
        col.prop(rpdat, 'arm_autoexposure_strength', text='Strength')
        layout.prop(rpdat, 'arm_lens_texture')
        layout.prop(rpdat, 'arm_lut_texture')