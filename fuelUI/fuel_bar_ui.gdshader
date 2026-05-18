shader_type canvas_item;
uniform int addX;
uniform int addY;
void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.x += float(addX);
	VERTEX.y += float(addY);
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR = texture(TEXTURE, vec2(UV.x + float(addX), UV.y + float(addY)));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
