shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float desaturate = 0.8;
uniform float darken = 0.2;
uniform float strength = 1.0;

void fragment() {
	vec4 screen_tex = texture(screen_texture, SCREEN_UV);

	float gray = dot(screen_tex.rgb, vec3(0.299, 0.587, 0.114));
	vec3 desaturated = mix(screen_tex.rgb, vec3(gray), desaturate);
	desaturated -= vec3(darken);

	vec3 final_color = mix(screen_tex.rgb, desaturated, strength);
	COLOR = vec4(final_color, 1.0);
}
