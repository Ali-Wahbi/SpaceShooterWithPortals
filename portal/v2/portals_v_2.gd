@tool
extends Node2D

@export var isPart1: bool = true:
	set(value):
		isPart1 = value
		if sideSprite:
			var anim = "portalSide1" if isPart1 else "portalSide2"
			sideSprite.animation = anim
		if collision:
			collision.rotation_degrees = -90 if isPart1 else 90

			# sideSprite.p
@export var isVertical: bool = true:
	set(value):
		isVertical = value
		if sideSprite:
			rotation_degrees = 90 if isVertical else 0
			
@export var sideSprite: AnimatedSprite2D
@export var collision: RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sideSprite.play(sideSprite.animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_collision_body_exited(body: Node) -> void:
	print("Entered: ", body)

func _on_collision_body_entered(body: Node) -> void:
	print("Exited: ", body)
