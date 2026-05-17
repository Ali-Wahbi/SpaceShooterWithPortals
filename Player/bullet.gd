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

func _on_body_entered(_body: Node) -> void:
	linear_velocity = Vector2.ZERO
	lifeTimer.stop()
	await get_tree().physics_frame
	forceDestroy()
