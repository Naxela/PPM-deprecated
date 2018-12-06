#version 450

#include "compiled.inc"

uniform sampler2D tex;

uniform float bloomThresholdPPV;
uniform vec3 bloomTintPPV;

in vec2 texCoord;
out vec4 fragColor;

void main() {
	vec4 col = texture(tex, texCoord);
	float brightness = dot(col.rgb, vec3(0.2126, 0.7152, 0.0722));

#ifdef _CPPV
	if (brightness > bloomThresholdPPV) {
		fragColor.rgb = col.rgb;
		fragColor.rgb *= bloomTintPPV;
		return;
	}
#else
	if (brightness > bloomThreshold) {
		fragColor.rgb = col.rgb;
		return;
	}
#endif

	fragColor.rgb = vec3(0.0);
}
