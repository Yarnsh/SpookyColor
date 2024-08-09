shader_type canvas_item;

uniform sampler2D base : source_color, filter_nearest;
uniform sampler2D resolution : source_color, filter_linear;

void fragment() {
	// TODO: blur this texture slightly when we use it
	float res_scale = texture(resolution, UV).r;
	
	//ugly, figure out something better later maybe
	if (res_scale > 0.5) {res_scale = 1.0;}
	else if (res_scale > 0.25) {res_scale = 0.5;}
	else if (res_scale > 0.125) {res_scale = 0.25;}
	else if (res_scale > 0.0625) {res_scale = 0.125;}
	else {res_scale = 0.0625;}
	
	vec2 new_uv = ceil((UV * (1.0/SCREEN_PIXEL_SIZE)) * res_scale) * (SCREEN_PIXEL_SIZE / res_scale);
	COLOR = texture(base, new_uv);
}
