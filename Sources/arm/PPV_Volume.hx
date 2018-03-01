package arm;

import iron.object.Object;
import kha.Framebuffer;
import kha.Assets;
import zui.*;

class PPV_Volume extends iron.Trait {

    var ui:Zui;
    var move = true;

	static var UIMode = 0;

	var globalWhiteSpaceController:Float = armory.renderpath.PostProcessUniforms.global_whitebalance;
	var globalTintControllerR:Float = armory.renderpath.PostProcessUniforms.global_tint_r;
	var globalTintControllerG:Float = armory.renderpath.PostProcessUniforms.global_tint_g;
	var globalTintControllerB:Float = armory.renderpath.PostProcessUniforms.global_tint_b;
	var globalSaturationControllerR:Float = armory.renderpath.PostProcessUniforms.global_saturation_r;
	var globalSaturationControllerG:Float = armory.renderpath.PostProcessUniforms.global_saturation_g;
	var globalSaturationControllerB:Float = armory.renderpath.PostProcessUniforms.global_saturation_b;
	var globalContrastControllerR:Float = armory.renderpath.PostProcessUniforms.global_contrast_r;
	var globalContrastControllerG:Float = armory.renderpath.PostProcessUniforms.global_contrast_g;
	var globalContrastControllerB:Float = armory.renderpath.PostProcessUniforms.global_contrast_b;
	var globalGammaControllerR:Float = armory.renderpath.PostProcessUniforms.global_gamma_r;
	var globalGammaControllerG:Float = armory.renderpath.PostProcessUniforms.global_gamma_g;
	var globalGammaControllerB:Float = armory.renderpath.PostProcessUniforms.global_gamma_b;
	var globalGainControllerR:Float = armory.renderpath.PostProcessUniforms.global_gain_r;
	var globalGainControllerG:Float = armory.renderpath.PostProcessUniforms.global_gain_g;
	var globalGainControllerB:Float = armory.renderpath.PostProcessUniforms.global_gain_b;
	var globalOffsetControllerR:Float = armory.renderpath.PostProcessUniforms.global_offset_r;
	var globalOffsetControllerG:Float = armory.renderpath.PostProcessUniforms.global_offset_g;
	var globalOffsetControllerB:Float = armory.renderpath.PostProcessUniforms.global_offset_b;

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

        if (ui.window(Id.handle(), 0, 0, 200, 600, false)) {

			if (ui.panel(Id.handle({selected: false}), "Colorgrading Settings - Global")) {
				ui.text("Whitebalance");
				var global_WhiteBalance = ui.slider(Id.handle({value: 7500}), "Whitebalance", 1500, 15000, true);
				globalWhiteSpaceController = global_WhiteBalance;
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
					var global_Offset_Uniform = ui.slider(Id.handle({value: globalOffsetControllerR}), "Offset", 0, 2, true);
					
					globalSaturationControllerR = global_Saturation_Uniform;
					globalSaturationControllerG = global_Saturation_Uniform;
					globalSaturationControllerB = global_Saturation_Uniform;
					globalContrastControllerR = global_Contrast_Uniform;
					globalContrastControllerG = global_Contrast_Uniform;
					globalContrastControllerB = global_Contrast_Uniform;
					globalGammaControllerR = global_Gamma_Uniform;
					globalGammaControllerG = global_Gamma_Uniform;
					globalGammaControllerB = global_Gamma_Uniform;
					globalGainControllerR = global_Gain_Uniform;
					globalGainControllerG = global_Gain_Uniform;
					globalGainControllerB = global_Gain_Uniform;
					globalOffsetControllerR = global_Offset_Uniform;
					globalOffsetControllerG = global_Offset_Uniform;
					globalOffsetControllerB = global_Offset_Uniform;

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

					globalSaturationControllerR = global_Saturation_R;
					globalSaturationControllerG = global_Saturation_G;
					globalSaturationControllerB = global_Saturation_B;
					globalContrastControllerR = global_Contrast_R;
					globalContrastControllerG = global_Contrast_G;
					globalContrastControllerB = global_Contrast_B;
					globalGammaControllerR = global_Gamma_R;
					globalGammaControllerG = global_Gamma_G;
					globalGammaControllerB = global_Gamma_B;
					globalGainControllerR = global_Gain_R;
					globalGainControllerG = global_Gain_G;
					globalGainControllerB = global_Gain_B;
					globalOffsetControllerR = global_Offset_R;
					globalOffsetControllerG = global_Offset_G;
					globalOffsetControllerB = global_Offset_B;
					globalTintControllerR = global_Tint_R;
					globalTintControllerG = global_Tint_G;
					globalTintControllerB = global_Tint_B;
					
				} else if (UIMode == 2) {
					ui.text("Color Wheel not yet available");
				}

            }

        }
        ui.end();

        g.begin(false);
    }

	function update()
	{
		armory.renderpath.PostProcessUniforms.global_saturation_r = globalSaturationControllerR;
		armory.renderpath.PostProcessUniforms.global_saturation_g = globalSaturationControllerG;
		armory.renderpath.PostProcessUniforms.global_saturation_b = globalSaturationControllerB;
		armory.renderpath.PostProcessUniforms.global_contrast_r = globalContrastControllerR;
		armory.renderpath.PostProcessUniforms.global_contrast_g = globalContrastControllerG;
		armory.renderpath.PostProcessUniforms.global_contrast_b = globalContrastControllerB;
		armory.renderpath.PostProcessUniforms.global_gamma_r = globalGammaControllerR;
		armory.renderpath.PostProcessUniforms.global_gamma_g = globalGammaControllerG;
		armory.renderpath.PostProcessUniforms.global_gamma_b = globalGammaControllerB;
		armory.renderpath.PostProcessUniforms.global_gain_r = globalGainControllerR;
		armory.renderpath.PostProcessUniforms.global_gain_g = globalGainControllerG;
		armory.renderpath.PostProcessUniforms.global_gain_b = globalGainControllerB;
		armory.renderpath.PostProcessUniforms.global_offset_r = globalOffsetControllerR;
		armory.renderpath.PostProcessUniforms.global_offset_g = globalOffsetControllerG;
		armory.renderpath.PostProcessUniforms.global_offset_b = globalOffsetControllerB;
		armory.renderpath.PostProcessUniforms.global_tint_r = globalTintControllerR;
		armory.renderpath.PostProcessUniforms.global_tint_g = globalTintControllerG;
		armory.renderpath.PostProcessUniforms.global_tint_b = globalTintControllerB;
	}

}