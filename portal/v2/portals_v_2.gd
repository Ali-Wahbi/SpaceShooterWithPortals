@tool
class_name Portal
extends Node2D
@export var otherPortal: Portal
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
func _process(_delta: float) -> void:
	pass

var portalObjectsIDs: Array = []
func _on_collision_body_exited(body: Node) -> void:
	var index = portalObjectsIDs.find(body)
	if index != -1:
		print("Exited: ", body)
		portalObjectsIDs.remove_at(index)


func _on_collision_body_entered(body: Node) -> void:
	if otherPortal:
		var index = portalObjectsIDs.find(body)
		if index != -1:
			return

		print("Entered: ", body)
		if otherPortal.portalObjectsIDs.find(body) == -1:
			otherPortal.portalObjectsIDs.append(body)
		body.position = calculateNewBodyPos(body.position)


func calculateNewBodyPos(pos: Vector2) -> Vector2:
	var newPos: Vector2 = Vector2(0, 0)

	newPos = position - pos

	newPos = otherPortal.position - newPos


	return newPos