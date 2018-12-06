#version 450

#include "compiled.inc"

uniform sampler2D tex;

uniform float fringePPV;

in vec2 texCoord;
out vec4 fragColor;

void main() {
	vec3 col = vec3(0.0);
	col.r = texture(tex, texCoord + vec2(0.0, 1.0) * fringePPV / 1000).r;
	col.g = texture(tex, texCoord + vec2(-0.866, -0.5) * fringePPV / 1000).g;
	col.b = texture(tex, texCoord + vec2(0.866, -0.5) * fringePPV / 1000).b;

	fragColor.rgb = col;
}
