package armory.object;

import iron.Scene;
import iron.object.Object;
import iron.data.MaterialData;
import iron.math.Vec4;

// Structure for setting shader uniforms
class Uniforms {

	public static function register() {
		iron.object.Uniforms.externalTextureLinks = [textureLink];
		iron.object.Uniforms.externalVec3Links = [vec3Link];
		iron.object.Uniforms.externalFloatLinks = [floatLink];
	}

	public static function textureLink(object:Object, mat:MaterialData, link:String):kha.Image {
		if (link == "_smaaSearch") {
			return Scene.active.embedded.get('smaa_search.png');
		}
		else if (link == "_smaaArea") {
			return Scene.active.embedded.get('smaa_area.png');
		}
		#if arm_ltc
		else if (link == "_ltcMat") {
			if (armory.data.ConstData.ltcMatTex == null) armory.data.ConstData.initLTC();
			return armory.data.ConstData.ltcMatTex;
		}
		else if (link == "_ltcMag") {
			if (armory.data.ConstData.ltcMagTex == null) armory.data.ConstData.initLTC();
			return armory.data.ConstData.ltcMagTex;
		}
		#end
		else if (link == "_lensTexture") {
			return Scene.active.embedded.get('lenstexture.jpg');
		}
		else if (link == "_lutTexture") {
			return Scene.active.embedded.get('luttexture.jpg');
		}
		else if (link == "_cloudsTexture") {
			return Scene.active.embedded.get('cloudstexture.png');
		}
		return null;
	}

	public static function vec3Link(object:Object, mat:MaterialData, link:String):iron.math.Vec4 {
		var v:Vec4 = null;
		#if arm_hosek
		if (link == "_hosekA") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.A.x;
				v.y = armory.renderpath.HosekWilkie.data.A.y;
				v.z = armory.renderpath.HosekWilkie.data.A.z;
			}
		}
		else if (link == "_hosekB") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.B.x;
				v.y = armory.renderpath.HosekWilkie.data.B.y;
				v.z = armory.renderpath.HosekWilkie.data.B.z;
			}
		}
		else if (link == "_hosekC") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.C.x;
				v.y = armory.renderpath.HosekWilkie.data.C.y;
				v.z = armory.renderpath.HosekWilkie.data.C.z;
			}
		}
		else if (link == "_hosekD") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.D.x;
				v.y = armory.renderpath.HosekWilkie.data.D.y;
				v.z = armory.renderpath.HosekWilkie.data.D.z;
			}
		}
		else if (link == "_hosekE") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.E.x;
				v.y = armory.renderpath.HosekWilkie.data.E.y;
				v.z = armory.renderpath.HosekWilkie.data.E.z;
			}
		}
		else if (link == "_hosekF") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.F.x;
				v.y = armory.renderpath.HosekWilkie.data.F.y;
				v.z = armory.renderpath.HosekWilkie.data.F.z;
			}
		}
		else if (link == "_hosekG") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.G.x;
				v.y = armory.renderpath.HosekWilkie.data.G.y;
				v.z = armory.renderpath.HosekWilkie.data.G.z;
			}
		}
		else if (link == "_hosekH") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.H.x;
				v.y = armory.renderpath.HosekWilkie.data.H.y;
				v.z = armory.renderpath.HosekWilkie.data.H.z;
			}
		}
		else if (link == "_hosekI") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.I.x;
				v.y = armory.renderpath.HosekWilkie.data.I.y;
				v.z = armory.renderpath.HosekWilkie.data.I.z;
			}
		}
		else if (link == "_hosekZ") {
			if (armory.renderpath.HosekWilkie.data == null) {
				armory.renderpath.HosekWilkie.init(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.Z.x;
				v.y = armory.renderpath.HosekWilkie.data.Z.y;
				v.z = armory.renderpath.HosekWilkie.data.Z.z;
			}
		}
		else if (link == "_cameraPositionSnap") {
			#if arm_voxelgi
			v = iron.object.Uniforms.helpVec;
			var camera = iron.Scene.active.camera;
			v.set(camera.transform.worldx(), camera.transform.worldy(), camera.transform.worldz());
			var l = camera.lookWorld();
			var e = Main.voxelgiHalfExtents;
			v.x += l.x * e * 0.9;
			v.y += l.y * e * 0.9;
			var f = Main.voxelgiVoxelSize * 8; // Snaps to 3 mip-maps range
			v.set(Math.floor(v.x / f) * f, Math.floor(v.y / f) * f, Math.floor(v.z / f) * f);
			#end
		}
		#end
		return v;
	}

	public static function floatLink(object:Object, mat:MaterialData, link:String):Null<kha.FastFloat> {
		#if rp_dynres
		if (link == "_dynamicScale") {
			return armory.renderpath.DynamicResolutionScale.dynamicScale;
		}
		#end

		// To do: Set compiler if
		if (link == "_globalWhiteBalance") {
			return armory.renderpath.PostProcessUniforms.global_whitebalance;
		}
		if (link == "_globalTintR") {
			return armory.renderpath.PostProcessUniforms.global_tint_r;
		}
		if (link == "_globalTintG") {
			return armory.renderpath.PostProcessUniforms.global_tint_g;
		}
		if (link == "_globalTintB") {
			return armory.renderpath.PostProcessUniforms.global_tint_b;
		}
		if (link == "_globalSaturationR") {
			return armory.renderpath.PostProcessUniforms.global_saturation_r;
		}
		if (link == "_globalSaturationG") {
			return armory.renderpath.PostProcessUniforms.global_saturation_g;
		}
		if (link == "_globalSaturationB") {
			return armory.renderpath.PostProcessUniforms.global_saturation_b;
		}
		if (link == "_globalContrastR") {
			return armory.renderpath.PostProcessUniforms.global_contrast_r;
		}
		if (link == "_globalContrastG") {
			return armory.renderpath.PostProcessUniforms.global_contrast_b;
		}
		if (link == "_globalContrastB") {
			return armory.renderpath.PostProcessUniforms.global_contrast_g;
		}
		if (link == "_globalGammaR") {
			return armory.renderpath.PostProcessUniforms.global_gamma_r;
		}
		if (link == "_globalGammaG") {
			return armory.renderpath.PostProcessUniforms.global_gamma_g;
		}
		if (link == "_globalGammaB") {
			return armory.renderpath.PostProcessUniforms.global_gamma_b;
		}
		if (link == "_globalGainR") {
			return armory.renderpath.PostProcessUniforms.global_gain_r;
		}
		if (link == "_globalGainG") {
			return armory.renderpath.PostProcessUniforms.global_gain_g;
		}
		if (link == "_globalGainB") {
			return armory.renderpath.PostProcessUniforms.global_gain_b;
		}
		if (link == "_globalOffsetR") {
			return armory.renderpath.PostProcessUniforms.global_offset_r;
		}
		if (link == "_globalOffsetG") {
			return armory.renderpath.PostProcessUniforms.global_offset_g;
		}
		if (link == "_globalOffsetB") {
			return armory.renderpath.PostProcessUniforms.global_offset_b;
		}



		if (link == "_shadowSaturationR") {
			return armory.renderpath.PostProcessUniforms.shadow_saturation_r;
		}
		if (link == "_shadowSaturationG") {
			return armory.renderpath.PostProcessUniforms.shadow_saturation_g;
		}
		if (link == "_shadowSaturationB") {
			return armory.renderpath.PostProcessUniforms.shadow_saturation_b;
		}
		if (link == "_shadowContrastR") {
			return armory.renderpath.PostProcessUniforms.shadow_contrast_r;
		}
		if (link == "_shadowContrastG") {
			return armory.renderpath.PostProcessUniforms.shadow_contrast_b;
		}
		if (link == "_shadowContrastB") {
			return armory.renderpath.PostProcessUniforms.shadow_contrast_g;
		}
		if (link == "_shadowGammaR") {
			return armory.renderpath.PostProcessUniforms.shadow_gamma_r;
		}
		if (link == "_shadowGammaG") {
			return armory.renderpath.PostProcessUniforms.shadow_gamma_g;
		}
		if (link == "_shadowGammaB") {
			return armory.renderpath.PostProcessUniforms.shadow_gamma_b;
		}
		if (link == "_shadowGainR") {
			return armory.renderpath.PostProcessUniforms.shadow_gain_r;
		}
		if (link == "_shadowGainG") {
			return armory.renderpath.PostProcessUniforms.shadow_gain_g;
		}
		if (link == "_shadowGainB") {
			return armory.renderpath.PostProcessUniforms.shadow_gain_b;
		}
		if (link == "_shadowOffsetR") {
			return armory.renderpath.PostProcessUniforms.shadow_offset_r;
		}
		if (link == "_shadowOffsetG") {
			return armory.renderpath.PostProcessUniforms.shadow_offset_g;
		}
		if (link == "_shadowOffsetB") {
			return armory.renderpath.PostProcessUniforms.shadow_offset_b;
		}
		if (link == "_shadowMax") {
			return armory.renderpath.PostProcessUniforms.shadow_max;
		}


		if (link == "_midtonesSaturationR") {
			return armory.renderpath.PostProcessUniforms.midtones_saturation_r;
		}
		if (link == "_midtonesSaturationG") {
			return armory.renderpath.PostProcessUniforms.midtones_saturation_g;
		}
		if (link == "_midtonesSaturationB") {
			return armory.renderpath.PostProcessUniforms.midtones_saturation_b;
		}
		if (link == "_midtonesContrastR") {
			return armory.renderpath.PostProcessUniforms.midtones_contrast_r;
		}
		if (link == "_midtonesContrastG") {
			return armory.renderpath.PostProcessUniforms.midtones_contrast_b;
		}
		if (link == "_midtonesContrastB") {
			return armory.renderpath.PostProcessUniforms.midtones_contrast_g;
		}
		if (link == "_midtonesGammaR") {
			return armory.renderpath.PostProcessUniforms.midtones_gamma_r;
		}
		if (link == "_midtonesGammaG") {
			return armory.renderpath.PostProcessUniforms.midtones_gamma_g;
		}
		if (link == "_midtonesGammaB") {
			return armory.renderpath.PostProcessUniforms.midtones_gamma_b;
		}
		if (link == "_midtonesGainR") {
			return armory.renderpath.PostProcessUniforms.midtones_gain_r;
		}
		if (link == "_midtonesGainG") {
			return armory.renderpath.PostProcessUniforms.midtones_gain_g;
		}
		if (link == "_midtonesGainB") {
			return armory.renderpath.PostProcessUniforms.midtones_gain_b;
		}
		if (link == "_midtonesOffsetR") {
			return armory.renderpath.PostProcessUniforms.midtones_offset_r;
		}
		if (link == "_midtonesOffsetG") {
			return armory.renderpath.PostProcessUniforms.midtones_offset_g;
		}
		if (link == "_midtonesOffsetB") {
			return armory.renderpath.PostProcessUniforms.midtones_offset_b;
		}


		if (link == "_highlightsSaturationR") {
			return armory.renderpath.PostProcessUniforms.highlights_saturation_r;
		}
		if (link == "_highlightsSaturationG") {
			return armory.renderpath.PostProcessUniforms.highlights_saturation_g;
		}
		if (link == "_highlightsSaturationB") {
			return armory.renderpath.PostProcessUniforms.highlights_saturation_b;
		}
		if (link == "_highlightsContrastR") {
			return armory.renderpath.PostProcessUniforms.highlights_contrast_r;
		}
		if (link == "_highlightsContrastG") {
			return armory.renderpath.PostProcessUniforms.highlights_contrast_b;
		}
		if (link == "_highlightsContrastB") {
			return armory.renderpath.PostProcessUniforms.highlights_contrast_g;
		}
		if (link == "_highlightsGammaR") {
			return armory.renderpath.PostProcessUniforms.highlights_gamma_r;
		}
		if (link == "_highlightsGammaG") {
			return armory.renderpath.PostProcessUniforms.highlights_gamma_g;
		}
		if (link == "_highlightsGammaB") {
			return armory.renderpath.PostProcessUniforms.highlights_gamma_b;
		}
		if (link == "_highlightsGainR") {
			return armory.renderpath.PostProcessUniforms.highlights_gain_r;
		}
		if (link == "_highlightsGainG") {
			return armory.renderpath.PostProcessUniforms.highlights_gain_g;
		}
		if (link == "_highlightsGainB") {
			return armory.renderpath.PostProcessUniforms.highlights_gain_b;
		}
		if (link == "_highlightsOffsetR") {
			return armory.renderpath.PostProcessUniforms.highlights_offset_r;
		}
		if (link == "_highlightsOffsetG") {
			return armory.renderpath.PostProcessUniforms.highlights_offset_g;
		}
		if (link == "_highlightsOffsetB") {
			return armory.renderpath.PostProcessUniforms.highlights_offset_b;
		}
		if (link == "_highlightsMin") {
			return armory.renderpath.PostProcessUniforms.highlights_min;
		}
		
		if (link == '_vignetteModifier') {
			return armory.renderpath.PostProcessUniforms.vignette_modifier;
		}
		if (link == '_filmGrain') {
			return armory.renderpath.PostProcessUniforms.film_grain;
		}
		if (link == '_bloomStrengthModifier') {
			return armory.renderpath.PostProcessUniforms.bloom_strength_modifier;
		}
		if (link == '_bloomRadiusModifier') {
			return armory.renderpath.PostProcessUniforms.bloom_radius_modifier;
		}
		if (link == '_bloomThresholdModifier') {
			return armory.renderpath.PostProcessUniforms.bloom_threshold_modifier;
		}
		if (link == '_ssrStepModifier') {
			return armory.renderpath.PostProcessUniforms.ssr_step;
		}
		if (link == '_ssrStepMinModifier') {
			return armory.renderpath.PostProcessUniforms.ssr_step_min;
		}
		if (link == '_ssrSearchModifier') {
			return armory.renderpath.PostProcessUniforms.ssr_search;
		}
		if (link == '_ssrFalloffModifier') {
			return armory.renderpath.PostProcessUniforms.ssr_falloff;
		}
		if (link == '_ssrJitterModifier') {
			return armory.renderpath.PostProcessUniforms.ssr_jitter;
		}
		if (link == '_letterbox') {
			return armory.renderpath.PostProcessUniforms.letterbox;
		}
		if (link == '_fogAmountA') {
			return armory.renderpath.PostProcessUniforms.fog_amount_a;
		}
		if (link == '_fogAmountB') {
			return armory.renderpath.PostProcessUniforms.fog_amount_b;
		}
		if (link == '_sharpen') {
			return armory.renderpath.PostProcessUniforms.sharpen;
		}
		if (link == '_dofDistance') {
			return armory.renderpath.PostProcessUniforms.dof_distance;
		}
		if (link == '_dofLength') {
			return armory.renderpath.PostProcessUniforms.dof_length;
		}
		if (link == '_dofFStop') {
			return armory.renderpath.PostProcessUniforms.dof_fstop;
		}

		//N
		if (link == '_dofSamples') {
			return armory.renderpath.PostProcessUniforms.dof_samples;
		}
		if (link == '_dofRings') {
			return armory.renderpath.PostProcessUniforms.dof_rings;
		}
		if (link == '_dofMaxBlur') {
			return armory.renderpath.PostProcessUniforms.dof_max_blur;
		}
		if (link == '_dofGain') {
			return armory.renderpath.PostProcessUniforms.dof_gain;
		}
		if (link == '_dofBokehBias') {
			return armory.renderpath.PostProcessUniforms.dof_bokeh_bias;
		}
		if (link == '_dofFringe') {
			return armory.renderpath.PostProcessUniforms.dof_fringe;
		}
		if (link == '_dofDither') {
			return armory.renderpath.PostProcessUniforms.dof_dither;
		}
		if (link == '_dofFocusX') {
			return armory.renderpath.PostProcessUniforms.dof_focus_x;
		}
		if (link == '_dofFocusY') {
			return armory.renderpath.PostProcessUniforms.dof_focus_y;
		}

		//N
		if (link == '_ssgiMaxSteps') {
			return armory.renderpath.PostProcessUniforms.ssgi_max_steps;
		}
		if (link == '_ssgiRayStep') {
			return armory.renderpath.PostProcessUniforms.ssgi_ray_step;
		}
		if (link == '_ssgiStrength') {
			return armory.renderpath.PostProcessUniforms.ssgi_strength;
		}

		return null;
	}
}
