extends RigidBody2D

var minVelocity = 50
var maxVelocity = 50
var selectedVelocity: Vector2
var hp = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectedVelocity.x = randf_range(-maxVelocity, maxVelocity)
	selectedVelocity.y = randf_range(-maxVelocity, maxVelocity)
	linear_velocity = selectedVelocity
	print(selectedVelocity)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	print("Rock Hit")
	if body.is_in_group("Bullet"):
		takeDamage()


func takeDamage():
	hp -= 1
	if hp == 0:
		queue_free()
	else:
		setSprite()
	

func setSprite():
	var currentFrame = 3 - hp
	$Sprite2D.frame = currentFrame