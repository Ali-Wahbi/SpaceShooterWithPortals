extends Node2D
@export var onScreenOffset: Vector2 = Vector2(0.5, -5)
@export var ScreenMargin: float = 4
@export var SmoothingSpeed: float = 8

var cameraNode: Camera2D
var target: Node2D
var child: Label

var maxDistance = 999
var minDistance = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent()
	child = get_child(0)
	cameraNode = get_viewport().get_camera_2d()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not cameraNode:
		cameraNode = get_viewport().get_camera_2d()
		return
	
	var targetGlobalPos: Vector2 = target.global_position
	var viewPortDimensions: Vector2 = get_viewport().get_visible_rect().size
	var screenCoordintaes: Vector2 = (targetGlobalPos - cameraNode.global_position) * cameraNode.zoom + viewPortDimensions * 0.5
	var screenInsetRect: Rect2 = Rect2(Vector2.ZERO, viewPortDimensions).grow(-ScreenMargin)
	
	var targetdisplayPos: Vector2
	var targetdisRotation: float

	var dist = int(global_position.distance_to(targetGlobalPos))

	if screenInsetRect.has_point(screenCoordintaes):
#		target inside screen
		visible = false
		targetdisplayPos = targetGlobalPos + onScreenOffset
		targetdisRotation = 0.0
	else:
#		target outside screen
		visible = true
		var clampedX = clamp(screenCoordintaes.x, ScreenMargin, viewPortDimensions.x - ScreenMargin)
		var clampedy = clamp(screenCoordintaes.y, ScreenMargin, viewPortDimensions.y - ScreenMargin)
		var clampPos: Vector2 = Vector2(clampedX, clampedy)
		
		targetdisplayPos = cameraNode.global_position + (clampPos - viewPortDimensions * 0.5) / cameraNode.zoom
		var vectorToTarget: Vector2 = targetGlobalPos - targetdisplayPos
		targetdisRotation = vectorToTarget.angle() - PI * 0.5
	
	global_position = lerp(global_position, targetdisplayPos, delta * SmoothingSpeed)
	rotation = lerp(rotation, targetdisRotation, delta * SmoothingSpeed)
	calculateChild(dist)


func calculateChild(dist):
	child.rotation = - rotation
	dist = clamp(dist, minDistance, maxDistance)
	child.text = str(dist)
