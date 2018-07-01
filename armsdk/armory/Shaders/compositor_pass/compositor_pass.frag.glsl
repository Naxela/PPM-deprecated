#version 450

#include "compiled.glsl"
#include "std/tonemap.glsl"
#include "std/math.glsl"
#include "std/colorgrading.glsl"
#ifdef _CDOF
#include "std/dof.glsl"
#endif

uniform sampler2D tex;
uniform sampler2D gbufferD;

#ifdef _CLensTex
uniform sampler2D lensTexture;
#endif

#ifdef _CLUT
uniform sampler2D lutTexture;
#endif

#ifdef _Hist
uniform sampler2D histogram;
#endif

//To do: Find out how to send the values through Vec3
#ifdef _PPV
//Global Values
uniform float globalWhiteBalance;
uniform float globalTintR;
uniform float globalTintG;
uniform float globalTintB;
uniform float globalSaturationR;
uniform float globalSaturationG;
uniform float globalSaturationB;
uniform float globalContrastR;
uniform float globalContrastG;
uniform float globalContrastB;
uniform float globalGammaR;
uniform float globalGammaG;
uniform float globalGammaB;
uniform float globalGainR;
uniform float globalGainG;
uniform float globalGainB;
uniform float globalOffsetR;
uniform float globalOffsetG;
uniform float globalOffsetB;

uniform float shadowSaturationR;
uniform float shadowSaturationG;
uniform float shadowSaturationB;
uniform float shadowContrastR;
uniform float shadowContrastG;
uniform float shadowContrastB;
uniform float shadowGammaR;
uniform float shadowGammaG;
uniform float shadowGammaB;
uniform float shadowGainR;
uniform float shadowGainG;
uniform float shadowGainB;
uniform float shadowOffsetR;
uniform float shadowOffsetG;
uniform float shadowOffsetB;
uniform float shadowMax;

uniform float midtonesSaturationR;
uniform float midtonesSaturationG;
uniform float midtonesSaturationB;
uniform float midtonesContrastR;
uniform float midtonesContrastG;
uniform float midtonesContrastB;
uniform float midtonesGammaR;
uniform float midtonesGammaG;
uniform float midtonesGammaB;
uniform float midtonesGainR;
uniform float midtonesGainG;
uniform float midtonesGainB;
uniform float midtonesOffsetR;
uniform float midtonesOffsetG;
uniform float midtonesOffsetB;

uniform float highlightsSaturationR;
uniform float highlightsSaturationG;
uniform float highlightsSaturationB;
uniform float highlightsContrastR;
uniform float highlightsContrastG;
uniform float highlightsContrastB;
uniform float highlightsGammaR;
uniform float highlightsGammaG;
uniform float highlightsGammaB;
uniform float highlightsGainR;
uniform float highlightsGainG;
uniform float highlightsGainB;
uniform float highlightsOffsetR;
uniform float highlightsOffsetG;
uniform float highlightsOffsetB;
uniform float highlightsMin;

//Postprocess Effects
uniform float vignetteModifier;
uniform float filmGrain;
uniform float letterboxSize;
uniform float fogAmountA;
uniform float fogAmountB;
uniform float sharpen;

uniform float dofDistance;
uniform float dofLength;
uniform float dofFStop;
uniform float dofFocusX;
uniform float dofFocusY;
uniform int dofSamples;
uniform int dofRings;
#endif

// #ifdef _CPos
// uniform vec3 eye;
// uniform vec3 eyeLook;
// #endif

#ifdef _CGlare
uniform vec3 light;
uniform mat4 VP;
uniform vec3 eye;
uniform vec3 eyeLook;
uniform float aspectRatio;
#endif

#ifdef _CTexStep
uniform vec2 texStep;
#endif

#ifdef _CGrain
uniform float time;
#endif

#ifdef _DynRes
uniform float dynamicScale;
#endif

#ifdef _CFog
	uniform vec2 cameraProj;
#else
	#ifdef _CDOF
		uniform vec2 cameraProj;
	#else
		#ifdef _CGlare
			uniform vec2 cameraProj;
		#endif
	#endif
#endif


in vec2 texCoord;
// #ifdef _CPos
	// in vec3 viewRay;
// #endif
out vec4 fragColor;

#ifdef _CFog
// const vec3 compoFogColor = vec3(0.5, 0.6, 0.7);
// const float compoFogAmountA = 1.0; // b = 0.01
// const float compoFogAmountB = 1.0; // c = 0.1
// vec3 applyFog(vec3 rgb, // original color of the pixel
		 // float distance, // camera to point distance
		 // vec3 rayOri, // camera position
		 // vec3 rayDir) { // camera to point vector
	// float fogAmount = compoFogAmountB * exp(-rayOri.y * compoFogAmountA) * (1.0 - exp(-distance * rayDir.y * compoFogAmountA)) / rayDir.y;
	// return mix(rgb, compoFogColor, fogAmount);
// }
	#ifdef _PPV
		vec3 applyFog(vec3 rgb, float distance) {
			// float fogAmount = 1.0 - exp(-distance * compoFogAmountA);
			float fogAmount = 1.0 - exp(-distance * (fogAmountA / 100));
			return mix(rgb, compoFogColor, fogAmount);
		}
	#else
		vec3 applyFog(vec3 rgb, float distance) {
			// float fogAmount = 1.0 - exp(-distance * compoFogAmountA);
			float fogAmount = 1.0 - exp(-distance * (compoFogAmountA / 100));
			return mix(rgb, compoFogColor, fogAmount);
		}
	#endif
#endif

vec4 LUTlookup(in vec4 textureColor, in sampler2D lookupTable) {

    //Clamp to prevent weird results
    textureColor = clamp(textureColor, 0.0, 1.0);

    mediump float blueColor = textureColor.b * 63.0;
    mediump vec2 quad1;

    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);

    mediump vec2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);

    highp vec2 texelPosition1;
    texelPosition1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texelPosition1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

    highp vec2 texelPosition2;
    texelPosition2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texelPosition2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

    lowp vec4 newColor1 = texture(lookupTable, texelPosition1);
    lowp vec4 newColor2 = texture(lookupTable, texelPosition2);

    lowp vec4 colorGradedResult = mix(newColor1, newColor2, fract(blueColor));

    return colorGradedResult;

}

float vignette() {
	// vignetting from iq
	// return 0.4 + 0.6 * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
		//return (vignetteModifier * 2) * 0.3 + 0.7 * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
		//return 0.3 + 0.7 * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
#ifdef _PPV
		return (-vignetteModifier + 1) * 0.3 + 0.7 * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
#else
		return 0.3 + 0.7 * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
#endif

}

#ifdef _CGlare
// Based on lense flare implementation by musk
// https://www.shadertoy.com/view/4sX3Rs 
vec3 lensflare(vec2 uv, vec2 pos) {
	vec2 uvd = uv * (length(uv));
	float f2 = max(1.0/(1.0+32.0*pow(length(uvd+0.8*pos),2.0)),0.0)*0.25;
	float f22 = max(1.0/(1.0+32.0*pow(length(uvd+0.85*pos),2.0)),0.0)*0.23;
	float f23 = max(1.0/(1.0+32.0*pow(length(uvd+0.9*pos),2.0)),0.0)*0.21;
	
	vec2 uvx = mix(uv, uvd, -0.5);
	float f4 = max(0.01-pow(length(uvx+0.4*pos),2.4),0.0)*6.0;
	float f42 = max(0.01-pow(length(uvx+0.45*pos),2.4),0.0)*5.0;
	float f43 = max(0.01-pow(length(uvx+0.5*pos),2.4),0.0)*3.0;
	
	uvx = mix(uv, uvd, -0.4);
	float f5 = max(0.01-pow(length(uvx+0.2*pos),5.5),0.0)*2.0;
	float f52 = max(0.01-pow(length(uvx+0.4*pos),5.5),0.0)*2.0;
	float f53 = max(0.01-pow(length(uvx+0.6*pos),5.5),0.0)*2.0;
	
	uvx = mix(uv, uvd, -0.5);
	float f6 = max(0.01-pow(length(uvx-0.3*pos),1.6),0.0)*6.0;
	float f62 = max(0.01-pow(length(uvx-0.325*pos),1.6),0.0)*3.0;
	float f63 = max(0.01-pow(length(uvx-0.35*pos),1.6),0.0)*5.0;
	
	vec3 c = vec3(0.0);
	c.r += f2 + f4 + f5 + f6;
	c.g += f22 + f42 + f52 + f62;
	c.b += f23 + f43 + f53 + f63;
	return c;
}
#endif

void main() {
	vec2 texCo = texCoord;
#ifdef _DynRes
	texCo *= dynamicScale;
#endif

#ifdef _CFishEye
	const float fishEyeStrength = -0.01;
	const vec2 m = vec2(0.5, 0.5);
	vec2 d = texCo - m;
	float r = sqrt(dot(d, d));
	float power = (2.0 * PI / (2.0 * sqrt(dot(m, m)))) * fishEyeStrength;
	float bind;
	if (power > 0.0) { bind = sqrt(dot(m, m)); }
	else { bind = m.x; }
	if (power > 0.0) {
		texCo = m + normalize(d) * tan(r * power) * bind / tan(bind * power);
	}
	else {
		texCo = m + normalize(d) * atan(r * -power * 10.0) * bind / atan(-power * bind * 10.0);
	}
#endif

#ifdef _CDepth
	float depth = texture(gbufferD, texCo).r * 2.0 - 1.0;
#endif

#ifdef _CFXAA
	const float FXAA_REDUCE_MIN = 1.0 / 128.0;
	const float FXAA_REDUCE_MUL = 1.0 / 8.0;
	const float FXAA_SPAN_MAX = 8.0;
	
	vec2 tcrgbNW = (texCo + vec2(-1.0, -1.0) * texStep);
	vec2 tcrgbNE = (texCo + vec2(1.0, -1.0) * texStep);
	vec2 tcrgbSW = (texCo + vec2(-1.0, 1.0) * texStep);
	vec2 tcrgbSE = (texCo + vec2(1.0, 1.0) * texStep);
	vec2 tcrgbM = vec2(texCo);
	
	vec3 rgbNW = texture(tex, tcrgbNW).rgb;
	vec3 rgbNE = texture(tex, tcrgbNE).rgb;
	vec3 rgbSW = texture(tex, tcrgbSW).rgb;
	vec3 rgbSE = texture(tex, tcrgbSE).rgb;
	vec3 rgbM  = texture(tex, tcrgbM).rgb;
	vec3 luma = vec3(0.299, 0.587, 0.114);
	float lumaNW = dot(rgbNW, luma);
	float lumaNE = dot(rgbNE, luma);
	float lumaSW = dot(rgbSW, luma);
	float lumaSE = dot(rgbSE, luma);
	float lumaM  = dot(rgbM,  luma);
	float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
	float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));
	
	vec2 dir;
	dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
	dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));
	
	float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
						  (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);
	
	float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
	dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
			  max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
			  dir * rcpDirMin)) * texStep;
			  
	vec3 rgbA = 0.5 * (
		texture(tex, texCo + dir * (1.0 / 3.0 - 0.5)).rgb +
		texture(tex, texCo + dir * (2.0 / 3.0 - 0.5)).rgb);
	vec3 rgbB = rgbA * 0.5 + 0.25 * (
		texture(tex, texCo + dir * -0.5).rgb +
		texture(tex, texCo + dir * 0.5).rgb);
	
	float lumaB = dot(rgbB, luma);
	if ((lumaB < lumaMin) || (lumaB > lumaMax)) fragColor.rgb = rgbA;
	else fragColor.rgb = rgbB;

#else

	#ifdef _CDOF
	fragColor.rgb = dof(texCo, depth, tex, gbufferD, texStep, cameraProj);
	#else
	fragColor.rgb = texture(tex, texCo).rgb;
	#endif

/*
	#ifdef _CDOF
		#ifdef _PPV
			fragColor.rgb = dof(texCo, depth, tex, gbufferD, texStep, cameraProj, dofDistance, dofLength, dofFStop, vec2(dofFocusX, dofFocusY), dofSamples, dofRings);
		#else
			fragColor.rgb = dof(texCo, depth, tex, gbufferD, texStep, cameraProj, compoDOFDistance, compoDOFLength, compoDOFFstop, vec2(dofFocusX, dofFocusY), dofSamples, dofRings);
		#endif
	#else
	fragColor.rgb = texture(tex, texCo).rgb;
	#endif
*/

#endif
	
#ifdef _CSharpen
	vec3 col1 = texture(tex, texCo + vec2(-texStep.x, -texStep.y) * 1.5).rgb;
	vec3 col2 = texture(tex, texCo + vec2(texStep.x, -texStep.y) * 1.5).rgb;
	vec3 col3 = texture(tex, texCo + vec2(-texStep.x, texStep.y) * 1.5).rgb;
	vec3 col4 = texture(tex, texCo + vec2(texStep.x, texStep.y) * 1.5).rgb;
	vec3 colavg = (col1 + col2 + col3 + col4) * 0.25;
	#ifdef _PPV
		fragColor.rgb += (fragColor.rgb - colavg) * sharpen;
	#else
		fragColor.rgb += (fragColor.rgb - colavg) * compoSharpenStrength;
	#endif
#endif

#ifdef _CFog
	// if (depth < 1.0) {
		// vec3 pos = getPos(depth, cameraProj);
		// float dist = distance(pos, eye);
		float dist = linearize(depth, cameraProj);
		// vec3 eyedir = eyeLook;// normalize(eye + pos);
		// fragColor.rgb = applyFog(fragColor.rgb, dist, eye, eyedir);
		fragColor.rgb = applyFog(fragColor.rgb, dist);
	// }
#endif

#ifdef _CGlare
	if (dot(light, eyeLook) > 0.0) { // Facing light
		vec4 lndc = VP * vec4(light, 1.0);
		lndc.xy /= lndc.w;
		vec2 lss = lndc.xy * 0.5 + 0.5;
		float lssdepth = linearize(texture(gbufferD, lss).r * 2.0 - 1.0, cameraProj);
		float lightDistance = distance(eye, light);
		if (lightDistance <= lssdepth) {
			vec2 lensuv = texCo * 2.0 - 1.0;
			lensuv.x *= aspectRatio;
			vec3 lensflarecol = vec3(1.4, 1.2, 1.0) * lensflare(lensuv, lndc.xy);
			fragColor.rgb += lensflarecol;
		}
	}
#endif

#ifdef _CGrain
	// const float compoGrainStrength = 4.0;
	float x = (texCo.x + 4.0) * (texCo.y + 4.0) * (time * 10.0);
	#ifdef _PPV
		fragColor.rgb += vec3(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - 0.005) * filmGrain;
	#else
		fragColor.rgb += vec3(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - 0.005) * compoGrainStrength;
	#endif
#endif
	
#ifdef _CVignette
	fragColor.rgb *= vignette();
#endif

#ifdef _CExposure
	fragColor.rgb *= compoExposureStrength;
#endif

#ifdef _AutoExposure
	vec3 expo = textureLod(tex, vec2(0,0), 100).rgb;
	fragColor.rgb *= vec3(1.0) - min(expo, vec3(autoExposureStrength));
#endif
#ifdef _Hist // Auto-exposure
	if (texCoord.x < 0.1) fragColor.rgb = textureLod(histogram, vec2(0, 0), 9.0).rrr; // 512x512
	// float minBrightness = 0.03f;
	// float maxBrightness = 2.0f;
	// float minAdaptation = 0.60f;
	// float maxAdaptation = 0.9f;
	// float minFractionSum = minAdaptation * sumValue;
	// float maxFractionSum = maxAdaptation * sumValue;
	// float sumWithoutOutliers = 0.0f;
	// float sumWithoutOutliersRaw = 0.0f;
	// for (int i = 0; i < numHistogramBuckets; ++i) {
	// 	float localValue = luminanceHistogram[i];
	// 	float vmin = min(localValue, minFractionSum);
	// 	localValue -= vmin;
	// 	localValue = localValue - vmin;
	// 	minFractionSum -= vmin;
	// 	maxFractionSum -= vmin;
	// 	localValue = min(localValue, maxFractionSum);
	// 	maxFractionSum -= localValue;
	// 	float luminanceAtBucket = GetLuminanceAtBucket(i);
	// 	sumWithoutOutliers += luminanceAtBucket * localValue;
	// 	sumWithoutOutliersRaw += localValue;
	// }
	// float unclampedLuminance = sumWithoutOutliers / max(0.0001f, sumWithoutOutliersRaw);
	// float clampedLuminace = clamp(unclampedLuminance, minBrightness, maxBrightness);
#endif

#ifdef _CToneFilmic
	fragColor.rgb = tonemapFilmic(fragColor.rgb); // With gamma
#endif
#ifdef _CToneFilmic2
	fragColor.rgb = acesFilm(fragColor.rgb);
	fragColor.rgb = pow(fragColor.rgb, vec3(1.0 / 2.2));
#endif
#ifdef _CToneReinhard
	fragColor.rgb = tonemapReinhard(fragColor.rgb);
	fragColor.rgb = pow(fragColor.rgb, vec3(1.0 / 2.2));
#endif
#ifdef _CToneUncharted
	fragColor.rgb = tonemapUncharted2(fragColor.rgb);
	fragColor.rgb = pow(fragColor.rgb, vec3(1.0 / 2.2)); // To gamma
#endif
#ifdef _CToneNone
	fragColor.rgb = pow(fragColor.rgb, vec3(1.0 / 2.2)); // To gamma
#endif
	
#ifdef _CBW
	// fragColor.rgb = vec3(clamp(dot(fragColor.rgb, fragColor.rgb), 0.0, 1.0));
	fragColor.rgb = vec3((fragColor.r * 0.3 + fragColor.g * 0.59 + fragColor.b * 0.11) / 3.0) * 2.5;
#endif

// #ifdef _CContrast
	// -0.5 - 0.5
	// const float compoContrast = 0.2;
	// fragColor.rgb = ((fragColor.rgb - 0.5) * max(compoContrast + 1.0, 0.0)) + 0.5;
// #endif

// #ifdef _CBrighness
	// fragColor.rgb += compoBrightness;
// #endif

#ifdef _CLensTex
	fragColor.rgb += texture(lensTexture, texCo).rgb;
#endif

#ifdef _CLetterbox
	// const float compoLetterboxSize = 0.1;
	#ifdef _PPV
		fragColor.rgb *= 1.0 - step(0.5 - letterboxSize, abs(0.5 - texCo.y));
	#else
		fragColor.rgb *= 1.0 - step(0.5 - compoLetterboxSize, abs(0.5 - texCo.y));
	#endif
#endif

//3D LUT Implementation from GPUGems 2 by Nvidia
//https://developer.nvidia.com/gpugems/GPUGems2/gpugems2_chapter24.html

#ifdef _CLUT
	fragColor = LUTlookup(fragColor, lutTexture);
#endif

#ifdef _PPV

	//Global Values
		//TODO! - PUT THE COLORGRADING IN BEFORE THE LETTERBOX
		//fragColor.rgb = WhiteBalance(fragColor.rgb, 7500, time);

		float factor = 1;
		float colorTempK = globalWhiteBalance;
		vec3 ColorTempRGB = ColorTemperatureToRGB(colorTempK);

		float originalLuminance = Luminance(fragColor.rgb);
		vec3 blended = mix(fragColor.rgb, fragColor.rgb * ColorTempRGB, factor);
		vec3 resultHSL = RGBtoHSL(blended);
		vec3 luminancePreservedRGB = HSLtoRGB(vec3(resultHSL.x, resultHSL.y, originalLuminance));
		fragColor = vec4(mix(blended, luminancePreservedRGB, LUMINANCE_PRESERVATION), 1.0);
		//Todo - Fix luminance preservation (image is more blue'ish, maybe due to tonemapping conflicts)

		mat3 CCSaturation = mat3 (													//Saturation
			globalSaturationR * shadowSaturationR, globalSaturationG * shadowSaturationG, globalSaturationB * shadowSaturationB,				//Shadows + Global
			globalSaturationR * midtonesSaturationR, globalSaturationG * midtonesSaturationG, globalSaturationB * midtonesSaturationB,				//Midtones + Global
			globalSaturationR * highlightsSaturationR, globalSaturationG * highlightsSaturationG, globalSaturationB * highlightsSaturationB				//Highlights + Global
		);

		mat3 CCContrast = mat3 (
			globalContrastR * shadowContrastR, globalContrastG * shadowContrastG, globalContrastB * shadowContrastB,				//Shadows + Global
			globalContrastR * midtonesContrastR, globalContrastG * midtonesContrastG, globalContrastB * midtonesContrastB,				//Midtones + Global
			globalContrastR * highlightsContrastR, globalContrastG * highlightsContrastG, globalContrastB * highlightsContrastB				//Highlights + Global
		);

		mat3 CCGamma = mat3 (
			globalGammaR * shadowGammaR, globalGammaG * shadowGammaG, globalGammaB * shadowGammaB,				//Shadows + Global
			globalGammaR * midtonesGammaR, globalGammaG * midtonesGammaG, globalGammaB * midtonesGammaB,				//Midtones + Global
			globalGammaR * highlightsGammaR, globalGammaG * highlightsGammaG, globalGammaB * highlightsGammaB				//Highlights + Global
		);

		mat3 CCGain = mat3 (
			globalGainR * shadowGainR, globalGainG * shadowGainG, globalGainB * shadowGainB,				//Shadows + Global
			globalGainR * midtonesGainR, globalGainG * midtonesGainG, globalGainB * midtonesGainB,				//Midtones + Global
			globalGainR * highlightsGainR, globalGainG * highlightsGainG, globalGainB * highlightsGainB				//Highlights + Global
		);

		mat3 CCOffset = mat3 (
			globalOffsetR * shadowOffsetR, globalOffsetG * shadowOffsetG, globalOffsetB * shadowOffsetB,				//Shadows + Global
			globalOffsetR * midtonesOffsetR, globalOffsetG * midtonesOffsetG, globalOffsetB * midtonesOffsetB,				//Midtones + Global
			globalOffsetR * highlightsOffsetR, globalOffsetG * highlightsOffsetG, globalOffsetB	* highlightsOffsetB			//Highlights + Global
		);

		vec2 ToneWeights = vec2(shadowMax, highlightsMin);

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
		fragColor.rgb *= vec3(globalTintR,globalTintG,globalTintB);

#endif

}
