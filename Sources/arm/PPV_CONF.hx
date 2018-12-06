package arm;

import iron.object.Object;
import kha.Framebuffer;
import kha.Assets;
import zui.*;
import armory.renderpath.PostProcessUniforms.*;

class PPV_CONF extends iron.Trait {

	var ui:Zui;
    var move = true;

	static var UIMode = 0;
	static var UIon:Bool = false;

	var globalWhiteSpaceController:Float = ppv_global_uniforms[0][0];
	var globalShadowMaxController:Float = ppv_global_uniforms[0][1];
	var globalHighlightMinController:Float = ppv_global_uniforms[0][2];

	var globalController = [ for (x in 0...8) [ for (y in 0...3) ppv_global_uniforms[x][y]]];
	var shadowController = [ for (x in 0...5) [ for (y in 0...3) ppv_shadow_uniforms[x][y]]];
	var midtoneController = [ for (x in 0...5) [ for (y in 0...3) ppv_midtone_uniforms[x][y]]];
	var highlightController = [ for (x in 0...5) [ for (y in 0...3) ppv_midtone_uniforms[x][y]]];
	var postprocessController = [ for (x in 0...43) ppv_postprocess_uniforms[x]];

	public function new() {
		super();

        kha.Assets.loadFont("droid_sans", function(f:kha.Font) {
			ui = new Zui({font: f});
			iron.Scene.active.notifyOnInit(sceneInit);
        });
	}

	function sceneInit() {
		notifyOnRender2D(render2D);
		notifyOnUpdate(update);
	}

	function render2D(g:kha.graphics2.Graphics) {
        g.end();
        ui.begin(g);

		
		if(UIon == true){
			if (ui.window(Id.handle(), 0, 20, 200, 600, false)) {

				if (ui.panel(Id.handle({selected: false}), "Colorgrading Settings - Global")) {
					ui.text("Whitebalance");
					var global_WhiteBalance = ui.slider(Id.handle({value: 6500}), "Whitebalance", 1500, 14000, true);
					globalController[0][0] = global_WhiteBalance;
					ui.text("Exposure");
					var global_Exposure_Uniform = ui.slider(Id.handle({value: 2}), "Exposure", 0, 10, true);
					globalController[7][0] = global_Exposure_Uniform;
					globalController[7][1] = global_Exposure_Uniform;
					globalController[7][2] = global_Exposure_Uniform;
					ui.text("Value Mode");
					UIMode = ui.combo(Id.handle({position:UIMode}),["Uniform","RGB","ColorWheel"],null);
					if (UIMode == 0) {
						ui.text("Saturation");
						var global_Saturation_Uniform = ui.slider(Id.handle({value: 1}), "Saturation", 0, 2, true);
						ui.text("Contrast");
						var global_Contrast_Uniform = ui.slider(Id.handle({value: 1}), "Contrast", 0, 2, true);
						ui.text("Gamma");
						var global_Gamma_Uniform = ui.slider(Id.handle({value: 1}), "Gamma", 0, 2, true);
						ui.text("Gain");
						var global_Gain_Uniform = ui.slider(Id.handle({value: 1}), "Gain", 0, 2, true);
						ui.text("Offset");
						var global_Offset_Uniform = ui.slider(Id.handle({value: 1}), "Offset", 0, 2, true);
						
						globalController[2][0] = global_Saturation_Uniform;
						globalController[2][1] = global_Saturation_Uniform;
						globalController[2][2] = global_Saturation_Uniform;
						globalController[3][0] = global_Contrast_Uniform;
						globalController[3][1] = global_Contrast_Uniform;
						globalController[3][2] = global_Contrast_Uniform;
						globalController[4][0] = global_Gamma_Uniform;
						globalController[4][1] = global_Gamma_Uniform;
						globalController[4][2] = global_Gamma_Uniform;
						globalController[5][0] = global_Gain_Uniform;
						globalController[5][1] = global_Gain_Uniform;
						globalController[5][2] = global_Gain_Uniform;
						globalController[6][0] = global_Offset_Uniform;
						globalController[6][1] = global_Offset_Uniform;
						globalController[6][2] = global_Offset_Uniform;

					} else if (UIMode == 1) {

						ui.text("Saturation");
						var global_Saturation_R = ui.slider(Id.handle({value: 1}), "Saturation - R", 0, 2, true);
						var global_Saturation_G = ui.slider(Id.handle({value: 1}), "Saturation - G", 0, 2, true);
						var global_Saturation_B = ui.slider(Id.handle({value: 1}), "Saturation - B", 0, 2, true);
						ui.text("Contrast");
						var global_Contrast_R = ui.slider(Id.handle({value: 1}), "Contrast - R", 0, 2, true);
						var global_Contrast_G = ui.slider(Id.handle({value: 1}), "Contrast - G", 0, 2, true);
						var global_Contrast_B = ui.slider(Id.handle({value: 1}), "Contrast - B", 0, 2, true);
						ui.text("Gamma");
						var global_Gamma_R = ui.slider(Id.handle({value: 1}), "Gamma - R", 0, 2, true);
						var global_Gamma_G = ui.slider(Id.handle({value: 1}), "Gamma - G", 0, 2, true);
						var global_Gamma_B = ui.slider(Id.handle({value: 1}), "Gamma - B", 0, 2, true);
						ui.text("Gain");
						var global_Gain_R = ui.slider(Id.handle({value: 1}), "Gain - R", 0, 2, true);
						var global_Gain_G = ui.slider(Id.handle({value: 1}), "Gain - G", 0, 2, true);
						var global_Gain_B = ui.slider(Id.handle({value: 1}), "Gain - B", 0, 2, true);
						ui.text("Offset");
						var global_Offset_R = ui.slider(Id.handle({value: 1}), "Offset - R", 0, 2, true);
						var global_Offset_G = ui.slider(Id.handle({value: 1}), "Offset - G", 0, 2, true);
						var global_Offset_B = ui.slider(Id.handle({value: 1}), "Offset - B", 0, 2, true);
						ui.text("Scene Tint");
						var global_Tint_R = ui.slider(Id.handle({value: 1}), "Tint - R", 0, 2, true);
						var global_Tint_G = ui.slider(Id.handle({value: 1}), "Tint - G", 0, 2, true);
						var global_Tint_B = ui.slider(Id.handle({value: 1}), "Tint - B", 0, 2, true);

						globalController[1][0] = global_Tint_R;
						globalController[1][1] = global_Tint_G;
						globalController[1][2] = global_Tint_B;
						globalController[2][0] = global_Saturation_R;
						globalController[2][1] = global_Saturation_G;
						globalController[2][2] = global_Saturation_B;
						globalController[3][0] = global_Contrast_R;
						globalController[3][1] = global_Contrast_G;
						globalController[3][2] = global_Contrast_B;
						globalController[4][0] = global_Gamma_R;
						globalController[4][1] = global_Gamma_G;
						globalController[4][2] = global_Gamma_B;
						globalController[5][0] = global_Gain_R;
						globalController[5][1] = global_Gain_G;
						globalController[5][2] = global_Gain_B;
						globalController[6][0] = global_Offset_R;
						globalController[6][1] = global_Offset_G;
						globalController[6][2] = global_Offset_B;

					} else if (UIMode == 2) {
						ui.text("Color Wheel not yet available");
					}

				}
				if (ui.panel(Id.handle({selected: false}), "Colorgrading Settings - Shadow")) {
					ui.text("Shadow Max");
					var shadow_max = ui.slider(Id.handle({value: 1.0}), "Shadow Max", 0.0, 1.0, true);
					globalController[0][1] = shadow_max;
					ui.text("Value Mode");
					UIMode = ui.combo(Id.handle({position:UIMode}),["Uniform","RGB","ColorWheel"],null);
					if(UIMode == 0){
						ui.text("Saturation");
						var shadow_saturation_uniform = ui.slider(Id.handle({value: 1.0}), "Saturation", 0.0, 2.0, true);
						ui.text("Contrast");
						var shadow_contrast_uniform = ui.slider(Id.handle({value: 1.0}), "Contrast", 0.0, 2.0, true);
						ui.text("Gamma");
						var shadow_gamma_uniform = ui.slider(Id.handle({value: 1.0}), "Gamma", 0.0, 2.0, true);
						ui.text("Gain");
						var shadow_gain_uniform = ui.slider(Id.handle({value: 1.0}), "Gain", 0.0, 2.0, true);
						ui.text("offset");
						var shadow_offset_uniform = ui.slider(Id.handle({value: 1.0}), "Offset", 0.0, 2.0, true);

						for(i in 0...3){
							shadowController[0][i] = shadow_saturation_uniform;
							shadowController[1][i] = shadow_contrast_uniform;
							shadowController[2][i] = shadow_gamma_uniform;
							shadowController[3][i] = shadow_gain_uniform;
							shadowController[4][i] = shadow_offset_uniform;
						}

					} else if (UIMode == 1) {
						ui.text("Saturation");
						var shadow_saturation_r = ui.slider(Id.handle({value: 1.0}), "Saturation R", 0.0, 2.0, true);
						var shadow_saturation_g = ui.slider(Id.handle({value: 1.0}), "Saturation G", 0.0, 2.0, true);
						var shadow_saturation_b = ui.slider(Id.handle({value: 1.0}), "Saturation B", 0.0, 2.0, true);
						ui.text("Contrast");
						var shadow_contrast_r = ui.slider(Id.handle({value: 1.0}), "Contrast R", 0.0, 2.0, true);
						var shadow_contrast_g = ui.slider(Id.handle({value: 1.0}), "Contrast G", 0.0, 2.0, true);
						var shadow_contrast_b = ui.slider(Id.handle({value: 1.0}), "Contrast B", 0.0, 2.0, true);
						ui.text("Gamma");
						var shadow_gamma_r = ui.slider(Id.handle({value: 1.0}), "Gamma R", 0.0, 2.0, true);
						var shadow_gamma_g = ui.slider(Id.handle({value: 1.0}), "Gamma G", 0.0, 2.0, true);
						var shadow_gamma_b = ui.slider(Id.handle({value: 1.0}), "Gamma B", 0.0, 2.0, true);
						ui.text("Gain");
						var shadow_gain_r = ui.slider(Id.handle({value: 1.0}), "Gain R", 0.0, 2.0, true);
						var shadow_gain_g = ui.slider(Id.handle({value: 1.0}), "Gain G", 0.0, 2.0, true);
						var shadow_gain_b = ui.slider(Id.handle({value: 1.0}), "Gain B", 0.0, 2.0, true);
						ui.text("Offset");
						var shadow_offset_r = ui.slider(Id.handle({value: 1.0}), "Offset R", 0.0, 2.0, true);
						var shadow_offset_g = ui.slider(Id.handle({value: 1.0}), "Offset G", 0.0, 2.0, true);
						var shadow_offset_b = ui.slider(Id.handle({value: 1.0}), "Offset B", 0.0, 2.0, true);

						shadowController[0][0] = shadow_saturation_r;
						shadowController[0][1] = shadow_saturation_g;
						shadowController[0][2] = shadow_saturation_b;
						shadowController[1][0] = shadow_contrast_r;
						shadowController[1][1] = shadow_contrast_g;
						shadowController[1][2] = shadow_contrast_b;
						shadowController[2][0] = shadow_gamma_r;
						shadowController[2][1] = shadow_gamma_g;
						shadowController[2][2] = shadow_gamma_b;
						shadowController[3][0] = shadow_gain_r;
						shadowController[3][1] = shadow_gain_g;
						shadowController[3][2] = shadow_gain_b;
						shadowController[4][0] = shadow_offset_r;
						shadowController[4][1] = shadow_offset_g;
						shadowController[4][2] = shadow_offset_b;


					} else if (UIMode == 2) {
						ui.text("Saturation");
						ui.text("Contrast");
						ui.text("Gamma");
						ui.text("Gain");
						ui.text("Contrast");
					}
				}
				if (ui.panel(Id.handle({selected: false}), "Colorgrading Settings - Midtone")) {
					ui.text("Value Mode");
					UIMode = ui.combo(Id.handle({position:UIMode}),["Uniform","RGB","ColorWheel"],null);
					if(UIMode == 0){
						ui.text("Saturation");
						var midtone_saturation_uniform = ui.slider(Id.handle({value: 1.0}), "Saturation", 0.0, 2.0, true);
						ui.text("Contrast");
						var midtone_contrast_uniform = ui.slider(Id.handle({value: 1.0}), "Contrast", 0.0, 2.0, true);
						ui.text("Gamma");
						var midtone_gamma_uniform = ui.slider(Id.handle({value: 1.0}), "Gamma", 0.0, 2.0, true);
						ui.text("Gain");
						var midtone_gain_uniform = ui.slider(Id.handle({value: 1.0}), "Gain", 0.0, 2.0, true);
						ui.text("offset");
						var midtone_offset_uniform = ui.slider(Id.handle({value: 1.0}), "Offset", 0.0, 2.0, true);

						for(i in 0...3){
							midtoneController[0][i] = midtone_saturation_uniform;
							midtoneController[1][i] = midtone_contrast_uniform;
							midtoneController[2][i] = midtone_gamma_uniform;
							midtoneController[3][i] = midtone_gain_uniform;
							midtoneController[4][i] = midtone_offset_uniform;
						}

					} else if (UIMode == 1) {
						ui.text("Saturation");
						var midtone_saturation_r = ui.slider(Id.handle({value: 1.0}), "Saturation R", 0.0, 2.0, true);
						var midtone_saturation_g = ui.slider(Id.handle({value: 1.0}), "Saturation G", 0.0, 2.0, true);
						var midtone_saturation_b = ui.slider(Id.handle({value: 1.0}), "Saturation B", 0.0, 2.0, true);
						ui.text("Contrast");
						var midtone_contrast_r = ui.slider(Id.handle({value: 1.0}), "Contrast R", 0.0, 2.0, true);
						var midtone_contrast_g = ui.slider(Id.handle({value: 1.0}), "Contrast G", 0.0, 2.0, true);
						var midtone_contrast_b = ui.slider(Id.handle({value: 1.0}), "Contrast B", 0.0, 2.0, true);
						ui.text("Gamma");
						var midtone_gamma_r = ui.slider(Id.handle({value: 1.0}), "Gamma R", 0.0, 2.0, true);
						var midtone_gamma_g = ui.slider(Id.handle({value: 1.0}), "Gamma G", 0.0, 2.0, true);
						var midtone_gamma_b = ui.slider(Id.handle({value: 1.0}), "Gamma B", 0.0, 2.0, true);
						ui.text("Gain");
						var midtone_gain_r = ui.slider(Id.handle({value: 1.0}), "Gain R", 0.0, 2.0, true);
						var midtone_gain_g = ui.slider(Id.handle({value: 1.0}), "Gain G", 0.0, 2.0, true);
						var midtone_gain_b = ui.slider(Id.handle({value: 1.0}), "Gain B", 0.0, 2.0, true);
						ui.text("Offset");
						var midtone_offset_r = ui.slider(Id.handle({value: 1.0}), "Offset R", 0.0, 2.0, true);
						var midtone_offset_g = ui.slider(Id.handle({value: 1.0}), "Offset G", 0.0, 2.0, true);
						var midtone_offset_b = ui.slider(Id.handle({value: 1.0}), "Offset B", 0.0, 2.0, true);

						midtoneController[0][0] = midtone_saturation_r;
						midtoneController[0][1] = midtone_saturation_g;
						midtoneController[0][2] = midtone_saturation_b;
						midtoneController[1][0] = midtone_contrast_r;
						midtoneController[1][1] = midtone_contrast_g;
						midtoneController[1][2] = midtone_contrast_b;
						midtoneController[2][0] = midtone_gamma_r;
						midtoneController[2][1] = midtone_gamma_g;
						midtoneController[2][2] = midtone_gamma_b;
						midtoneController[3][0] = midtone_gain_r;
						midtoneController[3][1] = midtone_gain_g;
						midtoneController[3][2] = midtone_gain_b;
						midtoneController[4][0] = midtone_offset_r;
						midtoneController[4][1] = midtone_offset_g;
						midtoneController[4][2] = midtone_offset_b;

					} else if (UIMode == 2) {
						ui.text("Saturation");
						ui.text("Contrast");
						ui.text("Gamma");
						ui.text("Gain");
						ui.text("Contrast");
					}
				}
				if (ui.panel(Id.handle({selected: false}), "Colorgrading Settings - Highlight")) {
					ui.text("Highlight Min");
					var highlight_min = ui.slider(Id.handle({value: 0.0}), "Highlight Min", 0.0, 1.0, true);
					globalController[0][2] = highlight_min;
					ui.text("Value Mode");
					UIMode = ui.combo(Id.handle({position:UIMode}),["Uniform","RGB","ColorWheel"],null);
					if(UIMode == 0){
						ui.text("Saturation");
						var highlight_saturation_uniform = ui.slider(Id.handle({value: 1.0}), "Saturation", 0.0, 2.0, true);
						ui.text("Contrast");
						var highlight_contrast_uniform = ui.slider(Id.handle({value: 1.0}), "Contrast", 0.0, 2.0, true);
						ui.text("Gamma");
						var highlight_gamma_uniform = ui.slider(Id.handle({value: 1.0}), "Gamma", 0.0, 2.0, true);
						ui.text("Gain");
						var highlight_gain_uniform = ui.slider(Id.handle({value: 1.0}), "Gain", 0.0, 2.0, true);
						ui.text("offset");
						var highlight_offset_uniform = ui.slider(Id.handle({value: 1.0}), "Offset", 0.0, 2.0, true);

						for(i in 0...3){
							highlightController[0][i] = highlight_saturation_uniform;
							highlightController[1][i] = highlight_contrast_uniform;
							highlightController[2][i] = highlight_gamma_uniform;
							highlightController[3][i] = highlight_gain_uniform;
							highlightController[4][i] = highlight_offset_uniform;
						}

					} else if (UIMode == 1) {
						ui.text("Saturation");
						var highlight_saturation_r = ui.slider(Id.handle({value: 1.0}), "Saturation R", 0.0, 2.0, true);
						var highlight_saturation_g = ui.slider(Id.handle({value: 1.0}), "Saturation G", 0.0, 2.0, true);
						var highlight_saturation_b = ui.slider(Id.handle({value: 1.0}), "Saturation B", 0.0, 2.0, true);
						ui.text("Contrast");
						var highlight_contrast_r = ui.slider(Id.handle({value: 1.0}), "Contrast R", 0.0, 2.0, true);
						var highlight_contrast_g = ui.slider(Id.handle({value: 1.0}), "Contrast G", 0.0, 2.0, true);
						var highlight_contrast_b = ui.slider(Id.handle({value: 1.0}), "Contrast B", 0.0, 2.0, true);
						ui.text("Gamma");
						var highlight_gamma_r = ui.slider(Id.handle({value: 1.0}), "Gamma R", 0.0, 2.0, true);
						var highlight_gamma_g = ui.slider(Id.handle({value: 1.0}), "Gamma G", 0.0, 2.0, true);
						var highlight_gamma_b = ui.slider(Id.handle({value: 1.0}), "Gamma B", 0.0, 2.0, true);
						ui.text("Gain");
						var highlight_gain_r = ui.slider(Id.handle({value: 1.0}), "Gain R", 0.0, 2.0, true);
						var highlight_gain_g = ui.slider(Id.handle({value: 1.0}), "Gain G", 0.0, 2.0, true);
						var highlight_gain_b = ui.slider(Id.handle({value: 1.0}), "Gain B", 0.0, 2.0, true);
						ui.text("Offset");
						var highlight_offset_r = ui.slider(Id.handle({value: 1.0}), "Offset R", 0.0, 2.0, true);
						var highlight_offset_g = ui.slider(Id.handle({value: 1.0}), "Offset G", 0.0, 2.0, true);
						var highlight_offset_b = ui.slider(Id.handle({value: 1.0}), "Offset B", 0.0, 2.0, true);

						highlightController[0][0] = highlight_saturation_r;
						highlightController[0][1] = highlight_saturation_g;
						highlightController[0][2] = highlight_saturation_b;
						highlightController[1][0] = highlight_contrast_r;
						highlightController[1][1] = highlight_contrast_g;
						highlightController[1][2] = highlight_contrast_b;
						highlightController[2][0] = highlight_gamma_r;
						highlightController[2][1] = highlight_gamma_g;
						highlightController[2][2] = highlight_gamma_b;
						highlightController[3][0] = highlight_gain_r;
						highlightController[3][1] = highlight_gain_g;
						highlightController[3][2] = highlight_gain_b;
						highlightController[4][0] = highlight_offset_r;
						highlightController[4][1] = highlight_offset_g;
						highlightController[4][2] = highlight_offset_b;

					} else if (UIMode == 2) {
						ui.text("Saturation");
						ui.text("Contrast");
						ui.text("Gamma");
						ui.text("Gain");
						ui.text("Contrast");
					}
				}
				if (ui.panel(Id.handle({selected: false}), "Postprocess Settings")) {
					ui.text("Bloom");
					var bloom_strength_uniform = ui.slider(Id.handle({value: 4.5}), "Bloom Strength", 0.0, 10, true);
					var bloom_radius_uniform = ui.slider(Id.handle({value: 0.25}), "Bloom Radius", 0.0, 10, true);
					var bloom_threshold_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom Threshold", 0.0, 10, true);
					var bloom_x_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom X", 0.0, 10, true);
					var bloom_y_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom Y", 0.0, 10, true);
					var bloom_tint_r_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom R", 0.0, 10, true);
					var bloom_tint_g_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom G", 0.0, 10, true);
					var bloom_tint_b_uniform = ui.slider(Id.handle({value: 1.0}), "Bloom B", 0.0, 10, true);
					var lut_power_uniform = ui.slider(Id.handle({value: 1.0}), "Lut Power", 0.0, 10, true);
					var ssr_step_uniform = ui.slider(Id.handle({value: 0.1}), "SSR Step", 0.0, 1, true);
					var ssr_stepmin_uniform = ui.slider(Id.handle({value: 2.0}), "SSR StepMin", 0.0, 5, true);
					var ssr_search_uniform = ui.slider(Id.handle({value: 100}), "SSR Search", 0.0, 100, true);
					var ssr_falloff_uniform = ui.slider(Id.handle({value: 3.5}), "SSR Falloff", 0.0, 10, true);
					var ssr_jitter_uniform = ui.slider(Id.handle({value: 0.4}), "SSR Jitter", 0.0, 10, true);
					var ssr_maxSteps_uniform = ui.slider(Id.handle({value: 0.4}), "SSR Jitter", 0.0, 10, true);
					var ssr_binarySteps_uniform = ui.slider(Id.handle({value: 0.4}), "SSR Jitter", 0.0, 10, true);
					var film_grain_uniform = ui.slider(Id.handle({value: 0.0}), "Film Grain", 0.0, 10, true);
					var ssrs_uniform =  ui.slider(Id.handle({value: 0.01}), "SSRS Uniform", 0.0, 10, true);
					var letterbox_ratio_uniform =  ui.slider(Id.handle({value: 0.1}), "Letterbox Ratio", 0.0, 10, true);
					var penumbra_scale_uniform = ui.slider(Id.handle({value: 1.0}), "Penumbra Scale", 0.0, 10, true);
					var penumbra_distance_uniform = ui.slider(Id.handle({value: 1.0}), "Penumbra Distance", 0.0, 10, true);
					var sharpen_power_uniform = ui.slider(Id.handle({value: 0.0}), "Sharpen Power", 0.0, 10, true);
					var vignette_power_uniform = ui.slider(Id.handle({value: 1.0}), "Vignette Power", 0.0, 10, true);
					var vxgi_diffuse_uniform =  ui.slider(Id.handle({value: 2.0}), "Voxel GI Diffuse", 0.0, 10, true);
					var vxgi_specular_uniform =  ui.slider(Id.handle({value: 0.3}), "Voxel GI Specular", 0.0, 10, true);
					var vxgi_occlusion_uniform = ui.slider(Id.handle({value: 2.0}), "Voxel GI Occlusion", 0.0, 10, true);
					var vxgi_env_uniform = ui.slider(Id.handle({value: 0.0}), "Voxel Env Map", 0.0, 0.5, true);
					var vxgi_step_uniform = ui.slider(Id.handle({value: 2.5}), "Voxel Step", 0.1, 10, true);
					var vxgi_range_uniform = ui.slider(Id.handle({value: 1.0}), "Voxel Range", 0.1, 1, true);
					var vxgi_offset_uniform = ui.slider(Id.handle({value: 1.0}), "Voxel Offset", 0.0, 10, true);

					var dof_distance_uniform = ui.slider(Id.handle({value: 0.0}), "DOF Distance Map", 0.0, 50, true);
					var dof_fstop_uniform = ui.slider(Id.handle({value: 128.0}), "DOF FStop Map", 0.0, 200, true);
					var dof_length_uniform = ui.slider(Id.handle({value: 160.0}), "DOF Length Map", 0.0, 200, true);
					var dof_focusx_uniform = ui.slider(Id.handle({value: 0.5}), "DOF Focus X Map", 0.0, 1, true);
					var dof_focusy_uniform = ui.slider(Id.handle({value: 0.5}), "DOF Focus Y Map", 0.0, 1, true);
					var dof_coc_uniform = ui.slider(Id.handle({value: 0.11}), "DOF COC Map", 0.0, 10, true);
					var dof_maxblur_uniform = ui.slider(Id.handle({value: 1.0}), "DOF MaxBlur Map", 0.0, 10, true);
					var dof_threshold_uniform = ui.slider(Id.handle({value: 0.5}), "DOF Threshold Map", 0.0, 10, true);
					var dof_highlight_uniform = ui.slider(Id.handle({value: 2.0}), "DOF Highlight Map", 0.0, 10, true);
					var dof_bias_uniform = ui.slider(Id.handle({value: 0.5}), "DOF Bias Map", 0.0, 10, true);
					var dof_fringe_uniform = ui.slider(Id.handle({value: 0.7}), "DOF Fringe Map", 0.0, 10, true);
					var dof_dither_uniform = ui.slider(Id.handle({value: 0.0001}), "DOF Dither Map", 0.0, 1, true);

					var rtgi_step_uniform = ui.slider(Id.handle({value: 0.02}), "RTGI Step", 0.0, 1, true);
					var rtgi_strength_uniform = ui.slider(Id.handle({value: 0.11}), "RTGI Strength", 0.0, 1, true);
					var rtgi_stepMax_uniform = ui.slider(Id.handle({value: 0.0}), "RTGI Offset", 0.0, 1, true);
					ui.text("");ui.text("");ui.text("");

					postprocessController[0] = bloom_strength_uniform;
					postprocessController[1] = bloom_radius_uniform;
					postprocessController[2] = bloom_threshold_uniform;
					postprocessController[3] = bloom_x_uniform;
					postprocessController[4] = bloom_y_uniform;
					postprocessController[5] = bloom_tint_r_uniform;
					postprocessController[6] = bloom_tint_g_uniform;
					postprocessController[7] = bloom_tint_b_uniform;
					postprocessController[8] = lut_power_uniform;
					postprocessController[9] = ssr_step_uniform;
					postprocessController[10] = ssr_stepmin_uniform;
					postprocessController[11] = ssr_search_uniform;
					postprocessController[12] = ssr_falloff_uniform;
					postprocessController[13] = ssr_jitter_uniform;
					postprocessController[14] = film_grain_uniform;
					postprocessController[15] = ssrs_uniform;
					postprocessController[16] = letterbox_ratio_uniform;
					postprocessController[17] = Std.int(Math.fround(penumbra_scale_uniform));
					postprocessController[18] = penumbra_distance_uniform;
					postprocessController[19] = sharpen_power_uniform;
					postprocessController[20] = vignette_power_uniform;
					postprocessController[21] = vxgi_diffuse_uniform;
					postprocessController[22] = vxgi_specular_uniform * 10;
					postprocessController[23] = vxgi_occlusion_uniform;
					postprocessController[24] = vxgi_env_uniform;
					postprocessController[25] = vxgi_step_uniform;
					postprocessController[26] = vxgi_range_uniform;
					postprocessController[27] = vxgi_offset_uniform;
					postprocessController[28] = dof_distance_uniform;
					postprocessController[29] = dof_fstop_uniform;
					postprocessController[30] = dof_length_uniform;
					postprocessController[31] = dof_focusx_uniform;
					postprocessController[32] = dof_focusy_uniform;
					postprocessController[33] = dof_coc_uniform;
					postprocessController[34] = dof_maxblur_uniform;
					postprocessController[35] = dof_threshold_uniform;
					postprocessController[36] = dof_highlight_uniform;
					postprocessController[37] = dof_bias_uniform;
					postprocessController[38] = dof_fringe_uniform;
					postprocessController[39] = dof_dither_uniform;
					postprocessController[40] = rtgi_step_uniform;
					postprocessController[41] = rtgi_strength_uniform;
					postprocessController[42] = Std.int(Math.fround(rtgi_stepMax_uniform));
					//postprocessController[43] = 

				}
				if (ui.panel(Id.handle({selected: false}), "Preset Load/Save")) {

					if (ui.button("Save")){
						var data = armory.renderpath.PostProcessUniforms.ppv_global_uniforms + ";" +
						armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms+ ";" + 
						armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms+ ";" + 
						armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms;
						var bytes = haxe.io.Bytes.ofString(haxe.Json.stringify(data));
						Krom.fileSaveBytes("C:\\tmp\\config.arm", bytes.getData());
						trace("Saved!");
					}
					if (ui.button("Load")){
						iron.data.Data.getBlob("C:\\tmp\\config.arm", function(blob:kha.Blob){
							var data = haxe.Json.parse(blob.toString());
							trace(data);
						});
					}

				}

			}
		} else {

		}
        ui.end();

        g.begin(false);
    }

	function update()
	{

		if(iron.system.Input.getKeyboard().released("t")){
			if(UIon == false){
				UIon = true;
			} else {
				UIon = false;
			}
		}

		for (x in 0...8){
			for (y in 0...3) {
				ppv_global_uniforms[x][y] = globalController[x][y];
			}
		}

		for (x in 0...5){
			for (y in 0...3) {
				ppv_shadow_uniforms[x][y] = shadowController[x][y];
			}
		}

		for (x in 0...5){
			for (y in 0...3) {
				ppv_midtone_uniforms[x][y] = midtoneController[x][y];
			}
		}

		for (x in 0...5){
			for (y in 0...3) {
				ppv_highlight_uniforms[x][y] = highlightController[x][y];
			}
		}

		for (x in 0...43){
			ppv_postprocess_uniforms[x] = postprocessController[x];
		}

	}
}
