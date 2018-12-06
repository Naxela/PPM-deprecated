package armory.object;

import iron.Scene;
import iron.object.Object;
import iron.data.MaterialData;
import iron.math.Vec4;

// Structure for setting shader uniforms
class Uniforms {

	public static function register() {
		iron.object.Uniforms.externalTextureLinks = [textureLink];
		iron.object.Uniforms.externalVec2Links = [vec2Link];
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
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
				armory.renderpath.HosekWilkie.recompute(Scene.active.world);
			}
			if (armory.renderpath.HosekWilkie.data != null) {
				v = iron.object.Uniforms.helpVec;
				v.x = armory.renderpath.HosekWilkie.data.Z.x;
				v.y = armory.renderpath.HosekWilkie.data.Z.y;
				v.z = armory.renderpath.HosekWilkie.data.Z.z;
			}
		}
		#end
		#if arm_voxelgi
		if (link == "_cameraPositionSnap") {
			v = iron.object.Uniforms.helpVec;
			var camera = iron.Scene.active.camera;
			v.set(camera.transform.worldx(), camera.transform.worldy(), camera.transform.worldz());
			var l = camera.lookWorld();
			var e = Main.voxelgiHalfExtents;
			v.x += l.x * e * 0.9;
			v.y += l.y * e * 0.9;
			var f = Main.voxelgiVoxelSize * 8; // Snaps to 3 mip-maps range
			v.set(Math.floor(v.x / f) * f, Math.floor(v.y / f) * f, Math.floor(v.z / f) * f);
		}
		#end

		//#if rp_ppv
		//Global PPV
		if (link == "_globalWeight") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalTint") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalSaturation") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalContrast") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalGamma") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalGain") {
			var ppv_index = 5;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalOffset") {
			var ppv_index = 6;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}
		if (link == "_globalExposure") {
			var ppv_index = 7;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_global_uniforms[ppv_index][2];
		}

		//Shadow PPV
		if (link == "_shadowSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_shadow_uniforms[ppv_index][2];
		}

		//Midtone PPV
		if (link == "_midtoneSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_midtone_uniforms[ppv_index][2];
		}

		//Highlight PPV
		if (link == "_highlightSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][0];
			v.y = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][1];
			v.z = armory.renderpath.PostProcessUniforms.ppv_highlight_uniforms[ppv_index][2];
		}
		//#end

		//Post-Process Effects
		if (link == "_bloomTintPPV") {
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[5];
			v.y = armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[6];
			v.z = armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[7];
		}

		return v;
	}

	public static function vec2Link(object:Object, mat:MaterialData, link:String):iron.math.Vec4 {
		var v:Vec4 = null;

		if (link == "_bloomAnamorphyPPV"){
			v = iron.object.Uniforms.helpVec;
			v.x = armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[3];
			v.y = armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[4];
		}

		return v;
	}

	public static function floatLink(object:Object, mat:MaterialData, link:String):Null<kha.FastFloat> {
		#if rp_dynres
		if (link == "_dynamicScale") {
			return armory.renderpath.DynamicResolutionScale.dynamicScale;
		}
		#end

		if (link == "_bloomStrengthPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[0];
		}
		if (link == "_bloomRadiusPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[1];
		}
		if (link == "_bloomThresholdPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[2];
		}

		if (link == "_lutPowerPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[8];
		}
		if (link == "_ssrStepPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[9];
		}
		if (link == "_ssrStepMinPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[10];
		}
		if (link == "_ssrSearchPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[11];
		}
		if (link == "_ssrFalloffPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[12];
		}
		if (link == "_ssrJitterPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[13];
		}
		if (link == "_filmGrainPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[14];
		}
		if (link == "_ssrsStepPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[15];
		}
		if (link == "_letterboxRatioPPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[16];
		}
		if (link == "_penumbraScalePPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[17];
		}
		if (link == "_penumbraDistancePPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[18];
		}
		if (link == "_sharpenPower") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[19];
		}
		if (link == "_VignettePower") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[20];
		}
		if(link == "_vxgiDiff") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[21];
		}
		if(link == "_vxgiSpec") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[22];
		}
		if(link == "_vxgiOcc") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[23];
		}
		if(link == "_vxgiEnv") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[24];
		}
		if(link == "_vxgiStep") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[25];
		}
		if(link == "_vxgiRange") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[26];
		}
		if(link == "_vxgiOffset") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[27];
		}

		if(link == "_dofDistance") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[28];
		}
		if(link == "_dofFStop") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[29];
		}
		if(link == "_dofLength") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[30];
		}
		if(link == "_dofFocusX") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[31];
		}
		if(link == "_dofFocusY") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[32];
		}
		if(link == "_dofCOC") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[33];
		}
		if(link == "_dofMaxBlur") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[34];
		}
		if(link == "_dofThreshold") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[35];
		}
		if(link == "_dofHighlightGain") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[36];
		}
		if(link == "_dofBias") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[37];
		}
		if(link == "_dofFringe") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[38];
		}
		if(link == "_dofDither") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[39];
		}
		if(link == "_rtgiStep") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[40];
		}
		if(link == "_rtgiStrength") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[41];
		}
		if(link == "_rtgiMaxSteps") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[42];
		}
		if(link == "_fringePPV") {
			return armory.renderpath.PostProcessUniforms.ppv_postprocess_uniforms[43];
		}

		return null;
	}
}
