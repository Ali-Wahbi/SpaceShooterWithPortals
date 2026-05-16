extends CharacterBody2D


const SPEED = 300.0

@export var extraAngle: float = 90.0
@export var rotationSpeed: float = 10.0
var previousAngle: float = -1
func _physics_process(delta: float) -> void:
	# rotate based on mouse pos
	MousePosRotate(delta)
	# move when thrust is clicked
	# slow down when thrust is released
	move_and_slide()

func MousePosRotate(delta) -> void:
	var mouseRotation = global_position.angle_to_point(get_global_mouse_position())

	var correctRotations = mouseRotation + deg_to_rad(extraAngle)
	
	rotation = lerp_angle(rotation, correctRotations, rotationSpeed * delta)