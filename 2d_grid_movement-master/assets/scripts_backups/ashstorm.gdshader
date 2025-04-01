shader_type canvas_item;

const float speed = 100.0;
uniform float strength = 0.5;
uniform vec4 overlay_color = vec4(0.6, 0.4, 0.2, 0.3);
uniform vec4 colorA = vec4(0.45, 0.40, 0.35, 1.0);
uniform vec4 colorB = vec4(0.35, 0.30, 0.25, 1.0);
uniform vec4 colorC = vec4(0.25, 0.22, 0.20, 1.0);
const float particle_size = 3.5;
const float percentage_particles = 0.03;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 uv_offset = floor(UV * vec2(160.0, 90.0) * vec2(particle_size, particle_size));
    float noise = fract(sin(dot(uv_offset.xy, vec2(12.345, 67.89))) * 98765.1234 + TIME/3.0);
    //noise = mix(0.0, noise, strength);
	float one_minus_p = (1.0 - percentage_particles);
	float prob_a = one_minus_p + (percentage_particles * 0.4);
	float prob_b = prob_a + (percentage_particles * 0.3);
	float prob_c = prob_b + (percentage_particles * 0.2);
    vec4 sand_effect = noise < one_minus_p ? colorA * 0.5:  noise < prob_a ? colorA : noise < prob_b ? colorB : colorC;
    COLOR = sand_effect * strength * 0.6;
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