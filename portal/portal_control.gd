extends Node2D

@export var source: Sprite2D
@export var destination: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	# var tex = source.get_viewport().get_texture()
	# await RenderingServer.frame_post_draw
	await get_tree().create_timer(2).timeout
	var tex = source.material.get_shader_parameter("screen_texture")
	destination.material.set_shader_parameter("newTexture", tex)
	print("HERE: ", tex, destination.material.get_shader_parameter("newTexture"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
