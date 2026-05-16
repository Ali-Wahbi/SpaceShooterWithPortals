extends Node2D

@export var lerpSpeed: float = 10.0
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.lerp(get_global_mouse_position(), delta * lerpSpeed)
	# global_position = get_global_mouse_position()
