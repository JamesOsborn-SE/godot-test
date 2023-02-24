shader_type canvas_item;

uniform bool active = true;

void fragment() {
		
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 new_color = previous_color;
	if (active == true){
		new_color = vec4(1,1,1, previous_color.a);
	}
	COLOR = new_color;
}