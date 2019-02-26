#version 450

#define LUMINANCE_PRESERVATION 0.75
#define EPSILON 1e-10
#define LUMA1 0.2722287168
#define LUMA2 0.6740817658
#define LUMA3 0.0536895174

uniform vec3 globalWeight;
uniform vec3 globalTint;
uniform vec3 globalSaturation;
uniform vec3 globalContrast;
uniform vec3 globalGamma;
uniform vec3 globalGain;
uniform vec3 globalOffset;
uniform vec3 globalExposure;

uniform vec3 shadowSaturation;
uniform vec3 shadowContrast;
uniform vec3 shadowGamma;
uniform vec3 shadowGain;
uniform vec3 shadowOffset;

uniform vec3 midtoneSaturation;
uniform vec3 midtoneContrast;
uniform vec3 midtoneGamma;
uniform vec3 midtoneGain;
uniform vec3 midtoneOffset;

uniform vec3 highlightSaturation;
uniform vec3 highlightContrast;
uniform vec3 highlightGamma;
uniform vec3 highlightGain;
uniform vec3 highlightOffset;

/*
uniform vec3 globalWeight;
vec3 globalTint = vec3(1,1,1);
vec3 globalSaturation = vec3(1,1,1);
vec3 globalContrast = vec3(1,1,1);
vec3 globalGamma = vec3(1,1,1);
vec3 globalGain = vec3(1,1,1);
vec3 globalOffset = vec3(1,1,1);
vec3 globalExposure = vec3(1,1,1);

vec3 shadowSaturation = vec3(1,1,1);
vec3 shadowContrast = vec3(1,1,1);
vec3 shadowGamma = vec3(1,1,1);
vec3 shadowGain = vec3(1,1,1);
vec3 shadowOffset = vec3(1,1,1);

vec3 midtoneSaturation = vec3(1,1,1);
vec3 midtoneContrast = vec3(1,1,1);
vec3 midtoneGamma = vec3(1,1,1);
vec3 midtoneGain = vec3(1,1,1);
vec3 midtoneOffset = vec3(1,1,1);

vec3 highlightSaturation = vec3(1,1,1);
vec3 highlightContrast = vec3(1,1,1);
vec3 highlightGamma = vec3(1,1,1);
vec3 highlightGain = vec3(1,1,1);
vec3 highlightOffset = vec3(1,1,1);
*/

uniform sampler2D tex;
in vec2 texCoord;
out vec4 fragColor;

float saturate(float v) { return clamp(v, 0.0,       1.0);       }
vec2  saturate(vec2  v) { return clamp(v, vec2(0.0), vec2(1.0)); }
vec3  saturate(vec3  v) { return clamp(v, vec3(0.0), vec3(1.0)); }
vec4  saturate(vec4  v) { return clamp(v, vec4(0.0), vec4(1.0)); }

float LumaKey (vec3 color) {
    return dot(color, vec3(LUMA1, LUMA2, LUMA3)); 
}

vec3 ColorTemperatureToRGB(float temperatureInKelvins)
{
    vec3 retColor;
    
    temperatureInKelvins = clamp(temperatureInKelvins, 1000.0, 40000.0) / 100.0;
    
    if (temperatureInKelvins <= 66.0)
    {
        retColor.r = 1.0;
        retColor.g = saturate(0.39008157876901960784 * log(temperatureInKelvins) - 0.63184144378862745098);
    }
    else
    {
        float t = temperatureInKelvins - 60.0;
        retColor.r = saturate(1.29293618606274509804 * pow(t, -0.1332047592));
        retColor.g = saturate(1.12989086089529411765 * pow(t, -0.0755148492));
    }
    
    if (temperatureInKelvins >= 66.0)
        retColor.b = 1.0;
    else if(temperatureInKelvins <= 19.0)
        retColor.b = 0.0;
    else
        retColor.b = saturate(0.54320678911019607843 * log(temperatureInKelvins - 10.0) - 1.19625408914);

    return retColor;
}

float Luminance(vec3 color)
{
    float fmin = min(min(color.r, color.g), color.b);
    float fmax = max(max(color.r, color.g), color.b);
    return (fmax + fmin) / 2.0;
}

vec3 HUEtoRGB(float H)
{
    float R = abs(H * 6.0 - 3.0) - 1.0;
    float G = 2.0 - abs(H * 6.0 - 2.0);
    float B = 2.0 - abs(H * 6.0 - 4.0);
    return saturate(vec3(R,G,B));
}

vec3 HSLtoRGB(in vec3 HSL)
{
    vec3 RGB = HUEtoRGB(HSL.x);
    float C = (1.0 - abs(2.0 * HSL.z - 1.0)) * HSL.y;
    return (RGB - 0.5) * C + vec3(HSL.z);
}
 
vec3 RGBtoHCV(vec3 RGB)
{
    vec4 P = (RGB.g < RGB.b) ? vec4(RGB.bg, -1.0, 2.0/3.0) : vec4(RGB.gb, 0.0, -1.0/3.0);
    vec4 Q = (RGB.r < P.x) ? vec4(P.xyw, RGB.r) : vec4(RGB.r, P.yzx);
    float C = Q.x - min(Q.w, Q.y);
    float H = abs((Q.w - Q.y) / (6.0 * C + EPSILON) + Q.z);
    return vec3(H, C, Q.x);
}

vec3 RGBtoHSL(vec3 RGB)
{
    vec3 HCV = RGBtoHCV(RGB);
    float L = HCV.z - HCV.y * 0.5;
    float S = HCV.y / (1.0 - abs(L * 2.0 - 1.0) + EPSILON);
    return vec3(HCV.x, S, L);
}


vec3 ToneColorCorrection(vec3 Color, vec3 ColorSaturation, vec3 ColorContrast, vec3 ColorGamma, vec3 ColorGain, vec3 ColorOffset) {
    //First initialize the colorluma key
    float ColorLuma = LumaKey(Color);
    //Add the saturation with the above key
    Color = max(vec3(0,0,0), mix(ColorLuma.xxx, Color, ColorSaturation));
    //Contrast with slight color correction (0.18 coefficient)
    float ContrastCorrectionCoefficient = 0.18;
    Color = pow(Color * (1.0 / ContrastCorrectionCoefficient), ColorContrast) * ContrastCorrectionCoefficient;
    //Gamma
    Color = pow(Color, 1.0 / ColorGamma);
    //Gain and Offset
    Color = Color.rgb * ColorGain + (ColorOffset - 1);
    //Return the color corrected profile
    return Color;
}

vec3 FinalizeColorCorrection(vec3 Color, mat3 ColorSaturation, mat3 ColorContrast, mat3 ColorGamma, mat3 ColorGain, mat3 ColorOffset, vec2 Toneweights) {
    
    float CCShadowsMax = Toneweights.x;
    float CCHighlightsMin = Toneweights.y;

    //First initialize the colorluma key and set color correction weights
    float ColorLuma = LumaKey(Color);
    float CCWeightShadows = 1 - smoothstep(0, CCShadowsMax, ColorLuma);
    float CCWeightHighlights = smoothstep(CCHighlightsMin, 1, ColorLuma);
    float CCWeightMidtones = 1 - CCWeightShadows - CCWeightHighlights;

    vec3 CCColorShadows = ToneColorCorrection (
        Color,
        ColorSaturation[0],
        ColorContrast[0],
        ColorGamma[0],
        ColorGain[0],
        ColorOffset[0]
    );

    vec3 CCColorMidtones = ToneColorCorrection (
        Color,
        ColorSaturation[1],
        ColorContrast[1],
        ColorGamma[1],
        ColorGain[1],
        ColorOffset[1]
    );
    
    vec3 CCColorHighlights = ToneColorCorrection (
        Color,
        ColorSaturation[2],
        ColorContrast[2],
        ColorGamma[2],
        ColorGain[2],
        ColorOffset[2]
    );

    vec3 CombinedCCProfile = CCColorShadows * CCWeightShadows + CCColorMidtones * CCWeightMidtones + CCColorHighlights * CCWeightHighlights;

    return vec3(CombinedCCProfile);
}

void main() {
	vec2 texCo = texCoord;

	fragColor = textureLod(tex, texCo, 0.0);


		float factor = 1;
		float colorTempK = globalWeight.x;
		vec3 ColorTempRGB = ColorTemperatureToRGB(colorTempK);

		float originalLuminance = Luminance(fragColor.rgb);
		vec3 blended = mix(fragColor.rgb, fragColor.rgb * ColorTempRGB, factor);
		vec3 resultHSL = RGBtoHSL(blended);
		vec3 luminancePreservedRGB = HSLtoRGB(vec3(resultHSL.x, resultHSL.y, originalLuminance));
		fragColor = vec4(mix(blended, luminancePreservedRGB, LUMINANCE_PRESERVATION), 1.0);

		mat3 CCSaturation = mat3 (													//Saturation
			globalSaturation.r * shadowSaturation.r, globalSaturation.g * shadowSaturation.g, globalSaturation.b * shadowSaturation.b,				//Shadows + Global
			globalSaturation.r * midtoneSaturation.r, globalSaturation.g * midtoneSaturation.g, globalSaturation.b * midtoneSaturation.b,				//Midtones + Global
			globalSaturation.r * highlightSaturation.r, globalSaturation.g * highlightSaturation.g, globalSaturation.b * highlightSaturation.b				//Highlights + Global
		);

		mat3 CCContrast = mat3 (
			globalContrast.r * shadowContrast.r, globalContrast.g * shadowContrast.g, globalContrast.b * shadowContrast.b,				//Shadows + Global
			globalContrast.r * midtoneContrast.r, globalContrast.g * midtoneContrast.g, globalContrast.b * midtoneContrast.b,				//Midtones + Global
			globalContrast.r * highlightContrast.r, globalContrast.g * highlightContrast.g, globalContrast.b * highlightContrast.b				//Highlights + Global
		);

		mat3 CCGamma = mat3 (
			globalGamma.r * shadowGamma.r, globalGamma.g * shadowGamma.g, globalGamma.b * shadowGamma.b,				//Shadows + Global
			globalGamma.r * midtoneGamma.r, globalGamma.g * midtoneGamma.g, globalGamma.b * midtoneGamma.b,				//Midtones + Global
			globalGamma.r * highlightGamma.r, globalGamma.g * highlightGamma.g, globalGamma.b * highlightGamma.b				//Highlights + Global
		);

		mat3 CCGain = mat3 (
			globalGain.r * shadowGain.r, globalGain.g * shadowGain.g, globalGain.b * shadowGain.b,				//Shadows + Global
			globalGain.r * midtoneGain.r, globalGain.g * midtoneGain.g, globalGain.b * midtoneGain.b,				//Midtones + Global
			globalGain.r * highlightGain.r, globalGain.g * highlightGain.g, globalGain.b * highlightGain.b			//Highlights + Global
		);

		mat3 CCOffset = mat3 (
			globalOffset.r * shadowOffset.r, globalOffset.g * shadowOffset.g, globalOffset.b * shadowOffset.b,				//Shadows + Global
			globalOffset.r * midtoneOffset.r, globalOffset.g * midtoneOffset.g, globalOffset.b * midtoneOffset.b,				//Midtones + Global
			globalOffset.r * highlightOffset.r, globalOffset.g * highlightOffset.g, globalOffset.b	* highlightOffset.b			//Highlights + Global
		);

		vec2 ToneWeights = vec2(globalWeight.y, globalWeight.z);

		fragColor.rgb = FinalizeColorCorrection(
			fragColor.rgb, 
			CCSaturation, 
			CCContrast, 
			CCGamma, 
			CCGain, 
			CCOffset,
			ToneWeights
		);

		//Tint
		fragColor.rgb *= vec3(globalTint.r,globalTint.g,globalTint.b);


	//fragColor.rgb += vec3(0,0,1);
}
