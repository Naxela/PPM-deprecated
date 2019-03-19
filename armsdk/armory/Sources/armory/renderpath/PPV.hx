package armory.renderpath;

import iron.Scene;
import iron.object.Object;
import iron.data.MaterialData;
import iron.math.Vec4;

class PPV {

    public static var colorgrading_global_uniforms = [
        [6500.0, 1.0, 0.0],         //0: Whitebalance, Shadow Max, Highlight Min
        [1.0, 1.0, 1.0],            //1: Tint
        [1.0, 1.0, 1.0],            //2: Saturation
        [1.0, 1.0, 1.0],            //3: Contrast
        [1.0, 1.0, 1.0],            //4: Gamma
        [1.0, 1.0, 1.0],            //5: Gain
        [1.0, 1.0, 1.0],            //6: Offset
        [1.0, 1.0, 1.0]             //7: Exposure
    ];

    public static var colorgrading_shadow_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static var colorgrading_midtone_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static var colorgrading_highlight_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static function externalVec3Link(object:Object, mat:MaterialData, link:String):iron.math.Vec4 {
        var v:Vec4 = null;

		if (link == "_globalWeight") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalTint") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalSaturation") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalContrast") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalGamma") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalGain") {
			var ppv_index = 5;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalOffset") {
			var ppv_index = 6;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}
		if (link == "_globalExposure") {
			var ppv_index = 7;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_global_uniforms[ppv_index][0];
			v.y = colorgrading_global_uniforms[ppv_index][1];
			v.z = colorgrading_global_uniforms[ppv_index][2];
		}

		//Shadow PPV
		if (link == "_shadowSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppv_index][0];
			v.y = colorgrading_shadow_uniforms[ppv_index][1];
			v.z = colorgrading_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppv_index][0];
			v.y = colorgrading_shadow_uniforms[ppv_index][1];
			v.z = colorgrading_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppv_index][0];
			v.y = colorgrading_shadow_uniforms[ppv_index][1];
			v.z = colorgrading_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppv_index][0];
			v.y = colorgrading_shadow_uniforms[ppv_index][1];
			v.z = colorgrading_shadow_uniforms[ppv_index][2];
		}
		if (link == "_shadowOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_shadow_uniforms[ppv_index][0];
			v.y = colorgrading_shadow_uniforms[ppv_index][1];
			v.z = colorgrading_shadow_uniforms[ppv_index][2];
		}

		//Midtone PPV
		if (link == "_midtoneSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppv_index][0];
			v.y = colorgrading_midtone_uniforms[ppv_index][1];
			v.z = colorgrading_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppv_index][0];
			v.y = colorgrading_midtone_uniforms[ppv_index][1];
			v.z = colorgrading_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppv_index][0];
			v.y = colorgrading_midtone_uniforms[ppv_index][1];
			v.z = colorgrading_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppv_index][0];
			v.y = colorgrading_midtone_uniforms[ppv_index][1];
			v.z = colorgrading_midtone_uniforms[ppv_index][2];
		}
		if (link == "_midtoneOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_midtone_uniforms[ppv_index][0];
			v.y = colorgrading_midtone_uniforms[ppv_index][1];
			v.z = colorgrading_midtone_uniforms[ppv_index][2];
		}

		//Highlight PPV
		if (link == "_highlightSaturation") {
			var ppv_index = 0;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppv_index][0];
			v.y = colorgrading_highlight_uniforms[ppv_index][1];
			v.z = colorgrading_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightContrast") {
			var ppv_index = 1;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppv_index][0];
			v.y = colorgrading_highlight_uniforms[ppv_index][1];
			v.z = colorgrading_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightGamma") {
			var ppv_index = 2;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppv_index][0];
			v.y = colorgrading_highlight_uniforms[ppv_index][1];
			v.z = colorgrading_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightGain") {
			var ppv_index = 3;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppv_index][0];
			v.y = colorgrading_highlight_uniforms[ppv_index][1];
			v.z = colorgrading_highlight_uniforms[ppv_index][2];
		}
		if (link == "_highlightOffset") {
			var ppv_index = 4;
			v = iron.object.Uniforms.helpVec;
			v.x = colorgrading_highlight_uniforms[ppv_index][0];
			v.y = colorgrading_highlight_uniforms[ppv_index][1];
			v.z = colorgrading_highlight_uniforms[ppv_index][2];
		}

        return v;

    }

    public static function init() {
        iron.object.Uniforms.externalVec3Links = [externalVec3Link];
		iron.App.notifyOnUpdate(OnUpdate);
    }

	public static function OnUpdate() {
	}
}