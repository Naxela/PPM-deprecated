#version 450

#include "compiled.inc"

uniform sampler2D tex;
uniform mat4 PPMComp2;


in vec2 texCoord;
out vec4 fragColor;

void main() {
	vec3 col = textureLod(tex, texCoord, 0.0).rgb;
	float brightness = dot(col, vec3(0.2126, 0.7152, 0.0722));
	#ifdef _CPPM
		if (brightness > PPMComp2[1].y) {
			fragColor.rgb = col;
		}
		else {
			fragColor.rgb = vec3(0.0);
		}
	#else
		if (brightness > bloomThreshold) {
			fragColor.rgb = col;
		}
		else {
			fragColor.rgb = vec3(0.0);
		}
	#endif
	
}
