shader_type canvas_item;
//render_mode skip_vertex_transform;
uniform sampler2D screen_texture:hint_screen_texture;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
    // Read the pixel color from the screen at the current screen UV coordinates
    vec4 screen_color = texture(screen_texture, UV);
    
    // Output the inverted screen color as an example effect
    COLOR = vec4(screen_color.rgb, screen_color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
