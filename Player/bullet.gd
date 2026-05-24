extends RigidBody2D

@export var speed: float = 300
@export var lifeTime: float = 4.0
var lifeTimer: Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startLifeTimer()
	
func setSpriteFrame(spriteFrame: int):
	$Sprite2D.frame = spriteFrame

func fireInDirection(direction: float):
	var shootDirection = Vector2.from_angle(direction).normalized()
	rotation = direction
	linear_velocity = shootDirection * speed

func startLifeTimer():
	lifeTimer = Timer.new()
	add_child(lifeTimer)
	lifeTimer.start(lifeTime)
	await lifeTimer.timeout
	call_deferred("queue_free")

func forceDestroy():
	if lifeTimer.time_left >= 0:
		lifeTimer.stop()
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Rock"):
		linear_velocity = Vector2.ZERO
		lifeTimer.stop()
		await get_tree().physics_frame
		forceDestroy()

#region Portaling

var _portal_pos: Vector2
var _portal_vel: Vector2
var _needs_portal_teleport: bool = false

# Called by the portal script
func teleport_via_portal(new_pos: Vector2, new_vel: Vector2) -> void:
	_portal_pos = new_pos
	_portal_vel = new_vel
	_needs_portal_teleport = true
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _needs_portal_teleport:
		# 1. Modify the transform origin (position)
		var new_transform: Transform2D = state.transform
		new_transform.origin = _portal_pos
		state.transform = new_transform
		
		# 2. Re-apply the rotated velocity vector
		state.linear_velocity = _portal_vel
		
		_needs_portal_teleport = false