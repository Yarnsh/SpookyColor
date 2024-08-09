shader_type canvas_item;

uniform sampler2D base : source_color, filter_nearest;
uniform sampler2D resolution : source_color, filter_linear;

uniform vec3 col = vec3(0.0);

void fragment() {
	// resolution change
	float res_scale = 0.0;
	res_scale += texture(resolution, UV).r;
	
	if (res_scale > 0.5) {res_scale = 1.0;}
	else if (res_scale > 0.25) {res_scale = 0.5;}
	else if (res_scale > 0.125) {res_scale = 0.25;}
	else if (res_scale > 0.0625) {res_scale = 0.125;}
	else {res_scale = 0.0625;}
	
	vec2 new_uv = ceil((UV * (1.0/SCREEN_PIXEL_SIZE)) * res_scale) * (SCREEN_PIXEL_SIZE / res_scale);
	vec3 base_color = texture(base, new_uv).rgb;
	
	// color removal
	vec3 grayscale_value = vec3(dot(base_color.rgb, vec3(0.299, 0.587, 0.114)));
	// This has a side effect of making the grayscale darker if any of the colors are on
	// figure out a fix later maybe
	vec3 movb = max(vec3(1.0) - col, base_color);
	vec3 mov = vec3(min(movb.r, min(movb.g, movb.b)));
	
	COLOR.rgb = mix(min(grayscale_value, mov), base_color, col);
}
