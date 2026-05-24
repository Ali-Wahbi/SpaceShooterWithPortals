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
			sideSprite.flip_h = isPart1

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
		# Calculate the relative position from entry portal to the object
		var relative_pos: Vector2 = body.global_position - global_position
		
		# Calculate rotation difference between portals (add 180 so object goes OUT of the exit)
		var rot_diff: float = (otherPortal.global_rotation - global_rotation) + PI
		
		# Rotate the relative position and velocity vectors
		var new_pos: Vector2 = otherPortal.global_position + relative_pos.rotated(rot_diff)
		
		# Handle CharacterBody2D teleportation
		if body is CharacterBody2D:
			body.global_position = new_pos
			body.velocity = body.velocity.rotated(rot_diff)
			
		# Handle RigidBody2D teleportation
		elif body is RigidBody2D:
			if body.has_method("teleport_via_portal"):
				var new_vel: Vector2 = body.linear_velocity.rotated(rot_diff)
				body.teleport_via_portal(new_pos, new_vel)
