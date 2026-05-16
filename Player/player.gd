extends CharacterBody2D

@onready var bodySprite: Sprite2D = $BodySprite
@onready var thrusterSprite: Sprite2D = $ThrustersSprite

const SPEED = 300.0
const THRUST_LERP_SPEED = 3.0 # Adjust this value to control how quickly the velocity changes

@export var extraAngle: float = 90.0
@export var rotationSpeed: float = 10.0
@export var stoppingSpeed: float = 10.0
@export_range(0, 5, 1) var selectedBody: int

func _ready():
	thrusterSprite.visible = false
	thrusterSprite.frame = selectedBody
	bodySprite.frame = selectedBody

func _physics_process(delta: float) -> void:
	# rotate based on mouse pos
	MousePosRotate(delta)
	# move when thrust is clicked
	# slow down when thrust is released
	HandleInput(delta)
	
	move_and_slide()

func MousePosRotate(delta: float) -> void:
	var mouseRotation = global_position.angle_to_point(get_global_mouse_position())

	var correctRotations = mouseRotation + deg_to_rad(extraAngle)
	
	rotation = lerp_angle(rotation, correctRotations, rotationSpeed * delta)

func HandleInput(delta: float) -> void:
	if Input.is_action_pressed("Thrust"):
		print("Thrusting in direction")
		thrusterSprite.visible = true
		var target_direction: Vector2 = Vector2.from_angle(rotation - deg_to_rad(extraAngle)) # Use 'rotation' (radians) instead of 'rotation_degrees'
		var target_velocity: Vector2 = target_direction * SPEED
		velocity = velocity.lerp(target_velocity, THRUST_LERP_SPEED * delta) # Smoothly interpolate velocity
	
	if Input.is_action_just_released("Thrust"):
		print("Stopping Thrusting")
		thrusterSprite.visible = false
		velocity.x = move_toward(velocity.x, 0, stoppingSpeed * THRUST_LERP_SPEED * delta)
		velocity.y = move_toward(velocity.y, 0, stoppingSpeed * THRUST_LERP_SPEED * delta)

	if Input.is_action_just_pressed("Fire"):
		pass
