shader_type canvas_item;

uniform sampler2D base : source_color, filter_nearest;
uniform sampler2D resolution : source_color, filter_nearest;
uniform sampler2D spectrum : source_color, filter_nearest;

uniform vec3 global_spectrum = vec3(0.0);
uniform float min_res_scale = 0.0625;
uniform float max_res_scale = 1.0;

void fragment() {
	// resolution change
	float res_scale = 0.0;
	res_scale += texture(resolution, UV).r;
	res_scale = min(max_res_scale, max(res_scale, min_res_scale));
	
	float res_test = 0.5;
	while (res_scale <= res_test) {
		res_test = res_test * 0.5;
	}
	res_scale = res_test;
	res_scale = min(max_res_scale, max(res_scale, min_res_scale));
	
	// scale so things look the same as 1080p generally
	res_scale /= (1.0/SCREEN_PIXEL_SIZE.y) / 1080.0;
	
	vec2 new_uv = round((UV * (1.0/SCREEN_PIXEL_SIZE)) * res_scale) * (SCREEN_PIXEL_SIZE / res_scale);
	vec3 base_color = texture(base, new_uv).rgb;
	vec3 col = step(0.01, max(texture(spectrum, new_uv).rgb, global_spectrum));
	
	// color removal
	vec3 grayscale_value = vec3(dot(base_color.rgb, vec3(0.299, 0.587, 0.114)));
	// This has a side effect of making the grayscale darker if any of the colors are on
	// figure out a fix later maybe
	vec3 movb = max(vec3(1.0) - col, base_color);
	vec3 mov = vec3(min(movb.r, min(movb.g, movb.b)));
	
	COLOR.rgb = mix(min(grayscale_value, mov), base_color, col);
}
