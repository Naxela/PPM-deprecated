package armory.renderpath;

import iron.Scene;
import iron.object.Object;
import iron.data.MaterialData;
import iron.math.Vec4;

class PPM {

	//TODO:
	//1. Colorgrading Set [4x Nodes; Global, Shadow, Midtone, Highlight]
	//2. Camera Set [Exposure, Fisheye, DoF]
	//3. Anti-Aliasing Settings [FXAA]
	//4. Tonemapper
	//
	//
	//
	//

    public static var colorgrading_global_uniforms = [
        [6500.0, 1.0, 0.0],         //0: Whitebalance, Shadow Max, Highlight Min
        [1.0, 1.0, 1.0],            //1: Tint
        [1.0, 1.0, 1.0],            //2: Saturation
        [1.0, 1.0, 1.0],            //3: Contrast
        [1.0, 1.0, 1.0],            //4: Gamma
        [1.0, 1.0, 1.0],            //5: Gain
        [1.0, 1.0, 1.0],            //6: Offset
		[1.0, 1.0, 1.0]				//7: LUT Strength
    ];

    public static var colorgrading_shadow_uniforms = [
        [1.0, 1.0, 1.0], 			//0: Saturation
        [1.0, 1.0, 1.0], 			//1: Contrast
        [1.0, 1.0, 1.0], 			//2: Gamma
        [1.0, 1.0, 1.0], 			//3: Gain
        [1.0, 1.0, 1.0] 			//4: Offset
    ];

    public static var colorgrading_midtone_uniforms = [
        [1.0, 1.0, 1.0], 			//0: Saturation
        [1.0, 1.0, 1.0], 			//1: Contrast
        [1.0, 1.0, 1.0], 			//2: Gamma
        [1.0, 1.0, 1.0], 			//3: Gain
        [1.0, 1.0, 1.0] 			//4: Offset
    ];

    public static var colorgrading_highlight_uniforms = [
        [1.0, 1.0, 1.0], 			//0: Saturation
        [1.0, 1.0, 1.0], 			//1: Contrast
        [1.0, 1.0, 1.0], 			//2: Gamma
        [1.0, 1.0, 1.0], 			//3: Gain
        [1.0, 1.0, 1.0] 			//4: Offset
    ];

		//TODO! CALIBRATE DEFAULT VALUES
		//TODO! RENAME TO CAMERA Uniforms
	public static var compositor_uniforms = [
		1.0,				//0: Camera: F-Number
		2.8333,				//1: Camera: Shutter time
		100.0, 				//2: Camera: ISO
		0.0,				//3: Camera: Exposure Compensation
		0.01,				//4: Fisheye Distortion
		1,					//5: DoF AutoFocus §§ If true, it ignores the DoF Distance setting
		10.0,				//6: DoF Distance
		160.0,				//7: DoF Focal Length mm
		128					//8: DoF F-Stop
							//x: Fisheye Distortion
							//x: 
	];

	//

    public static function externalVec3Link(object:Object, mat:MaterialData, link:String):iron.math.Vec4 {
        var v:Vec4 = null;

		if (link == "_globalWeight") {
			var ppm_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalTint") {
			var ppm_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalSaturation") {
			var ppm_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalContrast") {
			var ppm_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalGamma") {
			var ppm_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalGain") {
			var ppm_index = 5;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}
		if (link == "_globalOffset") {
			var ppm_index = 6;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppm_index][0];
			v.y = colorgrading_global_uniforms[ppm_index][1];
			v.z = colorgrading_global_uniforms[ppm_index][2];
		}

		//Shadow ppm
		if (link == "_shadowSaturation") {
			var ppm_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppm_index][0];
			v.y = colorgrading_shadow_uniforms[ppm_index][1];
			v.z = colorgrading_shadow_uniforms[ppm_index][2];
		}
		if (link == "_shadowContrast") {
			var ppm_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppm_index][0];
			v.y = colorgrading_shadow_uniforms[ppm_index][1];
			v.z = colorgrading_shadow_uniforms[ppm_index][2];
		}
		if (link == "_shadowGamma") {
			var ppm_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppm_index][0];
			v.y = colorgrading_shadow_uniforms[ppm_index][1];
			v.z = colorgrading_shadow_uniforms[ppm_index][2];
		}
		if (link == "_shadowGain") {
			var ppm_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppm_index][0];
			v.y = colorgrading_shadow_uniforms[ppm_index][1];
			v.z = colorgrading_shadow_uniforms[ppm_index][2];
		}
		if (link == "_shadowOffset") {
			var ppm_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppm_index][0];
			v.y = colorgrading_shadow_uniforms[ppm_index][1];
			v.z = colorgrading_shadow_uniforms[ppm_index][2];
		}

		//Midtone ppm
		if (link == "_midtoneSaturation") {
			var ppm_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppm_index][0];
			v.y = colorgrading_midtone_uniforms[ppm_index][1];
			v.z = colorgrading_midtone_uniforms[ppm_index][2];
		}
		if (link == "_midtoneContrast") {
			var ppm_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppm_index][0];
			v.y = colorgrading_midtone_uniforms[ppm_index][1];
			v.z = colorgrading_midtone_uniforms[ppm_index][2];
		}
		if (link == "_midtoneGamma") {
			var ppm_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppm_index][0];
			v.y = colorgrading_midtone_uniforms[ppm_index][1];
			v.z = colorgrading_midtone_uniforms[ppm_index][2];
		}
		if (link == "_midtoneGain") {
			var ppm_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppm_index][0];
			v.y = colorgrading_midtone_uniforms[ppm_index][1];
			v.z = colorgrading_midtone_uniforms[ppm_index][2];
		}
		if (link == "_midtoneOffset") {
			var ppm_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppm_index][0];
			v.y = colorgrading_midtone_uniforms[ppm_index][1];
			v.z = colorgrading_midtone_uniforms[ppm_index][2];
		}

		//Highlight ppm
		if (link == "_highlightSaturation") {
			var ppm_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppm_index][0];
			v.y = colorgrading_highlight_uniforms[ppm_index][1];
			v.z = colorgrading_highlight_uniforms[ppm_index][2];
		}
		if (link == "_highlightContrast") {
			var ppm_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppm_index][0];
			v.y = colorgrading_highlight_uniforms[ppm_index][1];
			v.z = colorgrading_highlight_uniforms[ppm_index][2];
		}
		if (link == "_highlightGamma") {
			var ppm_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppm_index][0];
			v.y = colorgrading_highlight_uniforms[ppm_index][1];
			v.z = colorgrading_highlight_uniforms[ppm_index][2];
		}
		if (link == "_highlightGain") {
			var ppm_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppm_index][0];
			v.y = colorgrading_highlight_uniforms[ppm_index][1];
			v.z = colorgrading_highlight_uniforms[ppm_index][2];
		}
		if (link == "_highlightOffset") {
			var ppm_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppm_index][0];
			v.y = colorgrading_highlight_uniforms[ppm_index][1];
			v.z = colorgrading_highlight_uniforms[ppm_index][2];
		}

        return v;

    }

	public static function externalMat4Link(object:Object, mat:MaterialData, link:String):iron.math.Mat4 {
		var m:iron.math.Mat4 = null;

		if (link == "_PPMComp1") {
			m = iron.object.Uniforms.helpMat;
			m._00 = compositor_uniforms[0];
			m._01 = compositor_uniforms[1];
			m._02 = compositor_uniforms[2];
			m._03 = compositor_uniforms[3];

			m._10 = compositor_uniforms[4];
			m._11 = compositor_uniforms[5];
			m._12 = compositor_uniforms[6];
			m._13 = compositor_uniforms[7];

			m._20 = compositor_uniforms[8];
			m._21 = compositor_uniforms[5];
			m._22 = compositor_uniforms[6];
			m._23 = compositor_uniforms[7];
		}

		return m;

	}


	/*
	public static function externalFloatLink(object:Object, mat:MaterialData, link:String):Float {
		
		if(link == "_compFNumber") {
			v = compositor_uniforms[0];
		}
		if(link == "_compShutterTime") {
			v = compositor_uniforms[1];
		}
		if(link == "_compISO") {
			v = compositor_uniforms[2];
		}
		if(link == "_compExposureCompensation") {
			v = compositor_uniforms[3];
		}
		
		return v;
	}
	*/

    public static function init() {
        iron.object.Uniforms.externalVec3Links = [externalVec3Link];
		iron.object.Uniforms.externalMat4Links = [externalMat4Link];

		//iron.object.Uniforms.externalFloatLinks = [externalFloatLink];
		iron.App.notifyOnUpdate(OnUpdate);
    }

	public static function OnUpdate() {
	}
}