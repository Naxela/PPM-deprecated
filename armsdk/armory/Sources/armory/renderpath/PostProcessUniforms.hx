package armory.renderpath;

import iron.math.Vec4;

class PostProcessUniforms {

    //Colorgrading Modifiers
    ////////////////////////
    //To do! - Find a way to pass RGB as vec3 variables

    //Postprocess Volume Configurations
    public static var LastVolumeSettings = [];
    public static var CurrentVolumeSettings = [];

    //Check this to designate whether to be a value or a modifier
    public static var OverrideIndex = [
        0
    ];

    //Global vec3 values
    public static var global_whitebalance = 7500.0;
    public static var global_tint_r = 1.0;
    public static var global_tint_g = 1.0;
    public static var global_tint_b = 1.0;
    public static var global_saturation_r = 1.0;
    public static var global_saturation_g = 1.0;
    public static var global_saturation_b = 1.0;
    public static var global_contrast_r = 1.0;
    public static var global_contrast_g = 1.0;
    public static var global_contrast_b = 1.0;
    public static var global_gamma_r = 1.0;
    public static var global_gamma_g = 1.0;
    public static var global_gamma_b = 1.0;
    public static var global_gain_r = 1.0;
    public static var global_gain_g = 1.0;
    public static var global_gain_b = 1.0;
    public static var global_offset_r = 1.0;
    public static var global_offset_g = 1.0;
    public static var global_offset_b = 1.0;

    //Shadow vec3 values
    public static var shadow_saturation_r = 1.0;
    public static var shadow_saturation_g = 1.0;
    public static var shadow_saturation_b = 1.0;
    public static var shadow_contrast_r = 1.0;
    public static var shadow_contrast_g = 1.0;
    public static var shadow_contrast_b = 1.0;
    public static var shadow_gamma_r = 1.0;
    public static var shadow_gamma_g = 1.0;
    public static var shadow_gamma_b = 1.0;
    public static var shadow_gain_r = 1.0;
    public static var shadow_gain_g = 1.0;
    public static var shadow_gain_b = 1.0;
    public static var shadow_offset_r = 1.0;
    public static var shadow_offset_g = 1.0;
    public static var shadow_offset_b = 1.0;
    public static var shadow_max = 0.0;

    //Midtones vec3 values
    public static var midtones_saturation_r = 1.0;
    public static var midtones_saturation_g = 1.0;
    public static var midtones_saturation_b = 1.0;
    public static var midtones_contrast_r = 1.0;
    public static var midtones_contrast_g = 1.0;
    public static var midtones_contrast_b = 1.0;
    public static var midtones_gamma_r = 1.0;
    public static var midtones_gamma_g = 1.0;
    public static var midtones_gamma_b = 1.0;
    public static var midtones_gain_r = 1.0;
    public static var midtones_gain_g = 1.0;
    public static var midtones_gain_b = 1.0;
    public static var midtones_offset_r = 1.0;
    public static var midtones_offset_g = 1.0;
    public static var midtones_offset_b = 1.0;

    //Highlights vec3 values
    public static var highlights_saturation_r = 1.0;
    public static var highlights_saturation_g = 1.0;
    public static var highlights_saturation_b = 1.0;
    public static var highlights_contrast_r = 1.0;
    public static var highlights_contrast_g = 1.0;
    public static var highlights_contrast_b = 1.0;
    public static var highlights_gamma_r = 1.0;
    public static var highlights_gamma_g = 1.0;
    public static var highlights_gamma_b = 1.0;
    public static var highlights_gain_r = 1.0;
    public static var highlights_gain_g = 1.0;
    public static var highlights_gain_b = 1.0;
    public static var highlights_offset_r = 1.0;
    public static var highlights_offset_g = 1.0;
    public static var highlights_offset_b = 1.0;
    public static var highlights_min = 1.0;

    //Post Process Modifiers
    ////////////////////////
    public static var bloom_strength_modifier = 3.5; //Default: bloomStrength
    public static var bloom_radius_modifier = 3.0; //Default: bloomRadius
    public static var bloom_threshold_modifier = 1.0; //Default: bloomThreshold
    //Todo - Anamorphic bloom (ie. J.J.Abrams lights)
    //Bloom horizontal scaling
    //Bloom tinting
    //Bloom sharpening/cutoff

    public static var chromatic_aberration_strength = 1.0; //New Shader
    public static var chromatic_aberration_samples = 32; //New Shader
    public static var exposure = 0.0; //Todo - Default: compoExposureStrength
    public static var film_grain = 2.0; //Todo - Default: compoGrainStrength
    public static var fog_amount_a = 0.25; //Default: compoFogAmountA
    public static var fog_amount_b = 0.5; //Default: compoFogAmountB
    public static var fog_color_r = 0.25; //Todo - Default: compoFogColor[0]
    public static var fog_color_g = 0.25; //Todo - Default: compoFogColor[1]
    public static var fog_color_b = 0.25; //Todo - Default: compoFogColor[2]
    public static var lens_tex_strength = 1.0; //Custom compo modifier
    public static var letterbox = 0.1; //Default: compoLetterboxSize;
    public static var lut_tex_strength = 1.0; //Custom compo modifier
    public static var sharpen = 0.25; //Default: compoSharpenStrength
    public static var ssr_step = 0.04; //Default: ssrRayStep
    public static var ssr_step_min = 0.05; //Default: ssrMinRayStep
    public static var ssr_search = 5.0; //Default: ssrSearchDist
    public static var ssr_falloff = 5.0; //Default: ssrFalloffExp
    public static var ssr_jitter = 0.6; //Default: ssrJitter
    public static var ssrs_step = 0.01; //Todo - Default: ssrsRayStep
    public static var vignette_modifier = 1.0; //Custom compo modifier


    //To do ++
    //Look into SSGI and VXGI modifiers
    public static var ssgi_max_steps = 8.0;
    public static var ssgi_ray_step = 2.0 * 0.005;
    public static var ssgi_strength = 1.0;
    //Make a custom tonemapper

    //Camera Specific Modifiers
    ///////////////////////////
    public static var dof_distance = 0.1; //Default: compoDOFDistance
    public static var dof_length = 160.0; //Default: compoDOFFstop
    public static var dof_fstop = 128.0; //Default: compoDOFLength
    public static var dof_focus_x = 0.5;
    public static var dof_focus_y = 0.5;
    public static var dof_samples:Int = 6; //Todo 
    public static var dof_rings:Int = 6; //Todo 
    public static var dof_max_blur = 1.0; //Todo 
    public static var dof_gain = 2.0; //Todo 
    public static var dof_bokeh_bias = 0.5; //Todo 
    public static var dof_fringe = 0.7; //Todo 
    public static var dof_dither = 0.0001; //Todo 

    //Sun specific modifiers
    ////////////////////////
    public static var sun_x = 0;
    public static var sun_y = 0;
    public static var sun_z = 0;

    
}