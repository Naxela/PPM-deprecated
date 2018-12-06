package armory.renderpath;

import iron.math.Vec4;
import haxe.Timer;

class PostProcessUniforms {

    //Colorgrading Modifiers
    ////////////////////////

    //Postprocess Volume Configurations
    public static var LastVolumeSettings = [];
    public static var CurrentVolumeSettings = [];

    //Todo: Make a queue system
    //Todo: Make a fail-check system (for catching small time margin errors)
    //Todo: Make more easing options (than just lerp for now)
    //Todo: Look into injected? uniforms added into a later stage
    //Todo: Bloom increase resolution/samples

    private static function lerp(a:Float, b:Float, t:Float){
        return a + t * (b - a);
    }

    public static function ppv_global_transition(ppvTransition:Dynamic, transitionTime:Float){

        var startTime = Date.now().getTime();
        var transitionTime = transitionTime * 1000;
        var endTime = startTime + transitionTime;

        var prevValues = [ for (x in 0...7) [ for (y in 0...3) ppv_global_uniforms[x][y]]];
        
        var timer = new Timer(1);
        timer.run = function(){
            var currentTime = Date.now().getTime();

            if(currentTime < endTime){

                var progress = (currentTime - startTime) / transitionTime;

                for (x in 0...7){
                    for (y in 0...3) {
                        ppv_global_uniforms[x][y] = lerp(prevValues[x][y], ppvTransition[x][y], progress);
                    }
                }
            } else 
            {
                timer.stop();
            }
        }
    }

    public static function ppv_shadow_transition(ppvTransition:Dynamic, transitionTime:Float, shadow_weight:Float){

        var startTime = Date.now().getTime();
        var transitionTime = transitionTime * 1000;
        var endTime = startTime + transitionTime;

        var prevValues = [ for (x in 0...5) [ for (y in 0...3) ppv_shadow_uniforms[x][y]]];
        var prevWeight = ppv_global_uniforms[0][1];
        
        var timer = new Timer(1);
        timer.run = function(){
            var currentTime = Date.now().getTime();

            if(currentTime < endTime){

                var progress = (currentTime - startTime) / transitionTime;

                for (x in 0...5){
                    for (y in 0...3) {
                        ppv_shadow_uniforms[x][y] = lerp(prevValues[x][y], ppvTransition[x][y], progress);
                    }
                }

                ppv_global_uniforms[0][1] = lerp(prevWeight, shadow_weight, progress);

            } else 
            {
                timer.stop();
            }
        }
    }

    public static function ppv_midtone_transition(ppvTransition:Dynamic, transitionTime:Float){

        var startTime = Date.now().getTime();
        var transitionTime = transitionTime * 1000;
        var endTime = startTime + transitionTime;

        var prevValues = [ for (x in 0...5) [ for (y in 0...3) ppv_midtone_uniforms[x][y]]];
        
        var timer = new Timer(1);
        timer.run = function(){
            var currentTime = Date.now().getTime();

            if(currentTime < endTime){

                var progress = (currentTime - startTime) / transitionTime;

                for (x in 0...5){
                    for (y in 0...3) {
                        ppv_midtone_uniforms[x][y] = lerp(prevValues[x][y], ppvTransition[x][y], progress);
                    }
                }
            } else 
            {
                timer.stop();
            }
        }
    }

    public static function ppv_highlight_transition(ppvTransition:Dynamic, transitionTime:Float, highlight_weight:Float){

        var startTime = Date.now().getTime();
        var transitionTime = transitionTime * 1000;
        var endTime = startTime + transitionTime;

        var prevValues = [ for (x in 0...5) [ for (y in 0...3) ppv_highlight_uniforms[x][y]]];
        var prevWeight = ppv_global_uniforms[0][2];
        
        var timer = new Timer(1);
        timer.run = function(){
            var currentTime = Date.now().getTime();

            if(currentTime < endTime){

                var progress = (currentTime - startTime) / transitionTime;

                for (x in 0...5){
                    for (y in 0...3) {
                        ppv_highlight_uniforms[x][y] = lerp(prevValues[x][y], ppvTransition[x][y], progress);
                    }
                }

                ppv_global_uniforms[0][2] = lerp(prevWeight, highlight_weight, progress);

            } else 
            {
                timer.stop();
            }
        }
    }

    public static var ppv_global_uniforms = [
        [6500.0, 1.0, 0.0],         //Whitebalance, Shadow Max, Highlight Min
        [1.0, 1.0, 1.0],            //Tint
        [1.0, 1.0, 1.0],            //Saturation
        [1.0, 1.0, 1.0],            //Contrast
        [1.0, 1.0, 1.0],            //Gamma
        [1.0, 1.0, 1.0],            //Gain
        [1.0, 1.0, 1.0],            //Offset
        [1.0, 1.0, 1.0]             //Exposure
    ];

    public static var ppv_shadow_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static var ppv_midtone_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static var ppv_highlight_uniforms = [
        [1.0, 1.0, 1.0], //Saturation
        [1.0, 1.0, 1.0], //Contrast
        [1.0, 1.0, 1.0], //Gamma
        [1.0, 1.0, 1.0], //Gain
        [1.0, 1.0, 1.0] //Offset
    ];

    public static var ppv_postprocess_uniforms2:Array<Dynamic> = [
        [3.5, 3.0, 1.0, [1.0, 1.0], [1.0, 1.0, 1.0]],     //0 - Bloom [0:Threshold, 1:Strength, 2:Radius, 3:Anamorphy, 4:Tint]
        [2.0, 1.0, 0.5],      //1 - SSAO [0: Size, 1: Strength, 2:Scale]
        [0.04, 0.05, 5.0, 5.0, 0.6]      //2 - SSR [0:Step, 1:StepMin, 2:Search, 3:Falloff, 4:Jitter]
    ];

    //TODO: REORGANIZE PROPERLY
    public static var ppv_postprocess_uniforms = [
        3.5,        //0 - Bloom: Strength
        3.0,        //1 - Bloom: Radius
        1.0,        //2 - Bloom: Threshold
        1.0,        //3 - Bloom: X
        1.0,        //4 - Bloom: Y

        1.0,        //5 R
        1.0,        //6 G
        1.0,        //7 B

        1.0,        //8 - LUT: Power
        0.04,       //9 - SSR: Step
        0.05,       //10 - SSR: StepMin
        5.0,        //11 - SSR: Search
        5.0,        //12 - SSR: Falloff
        0.6,        //13 - SSR: Jitter
        2.0,        //14 - Film Grain: Strength
        0.01,       //15 - SSRS: Step
        0.1,        //16 - Letterbox: Ratio
        1,          //17 - Penumbra: Scale
        1.0,        //18 - Penumbra: Distance
        0.25,       //19 - Sharpen Scale
        1,          //20 - Vignette
        3.0,        //21 - VXGI Diffuse
        1.0,        //22 - VXGI Specular
        1.0,        //23 - VXGI Occlusion
        0.0,        //24 - VXGI EnvMap
        1.0,        //25 - VXGI Step
        2.0,        //26 - VXGI Range
        1.0,         //27 - VXGI Offset

        0.0,        //DOF Distance //Distance 0 default is off
        128.0,      //DOF FStop
        160.0,      //DOF Length
        0.5,        //DOF Focus X
        0.5,        //DOF Focus Y
        0.11,       //DOF COC
        1.0,        //DOF Maxblur
        0.5,        //DOF Threshold
        2.0,        //DOF Highlight Gain
        0.5,        //DOF Bias
        0.7,        //DOF Fringe
        0.0001,     //39 DOF Dither
        2.0,        //40 RTGI Step
        1.0,        //41 Strength
        8,          //42 Max Steps
        0.0         //43 Fringe

    ];

    //Post Process Modifiers
    ////////////////////////
    //public static var bloom_strength_modifier = 3.5; //Default: bloomStrength
    //public static var bloom_radius_modifier = 3.0; //Default: bloomRadius
    //public static var bloom_threshold_modifier = 1.0; //Default: bloomThreshold
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