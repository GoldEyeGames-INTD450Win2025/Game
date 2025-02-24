shader_type canvas_item;

uniform float speed = 100.0;
uniform float strength = 0.5;
uniform vec4 overlay_color = vec4(0.6, 0.4, 0.2, 0.3);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 uv_offset = UV + vec2(TIME * speed, 0.0);
    float noise = fract(sin(dot(uv_offset, vec2(12.9898, 78.233))) * 43758.5453);
    float grain = mix(0.0, noise, strength);
    vec4 sand_effect = overlay_color * grain;
    COLOR = sand_effect;
}

//uniform sampler2D noise;
//uniform float strength: hint_range(0.0,1.0) = 0.5;
//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
//
//float rand(vec2 uv) {
	//return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
//}
//
//void fragment() {
	//vec4 screen_color = texture(SCREEN_TEXTURE,SCREEN_UV);
	//vec4 noise_tex = texture(noise,UV);
	//
	//vec4 random_color = vec4(rand(vec2(noise_tex.r, noise_tex.r)), rand(vec2(noise_tex.g, noise_tex.g) + vec2(1.0)), rand(vec2(noise_tex.b, noise_tex.b) + vec2(3.0)), 1.0);
	//
	//vec4 new_color = screen_color * random_color * 2.0;
	//COLOR = mix(screen_color, new_color, strength);
//}