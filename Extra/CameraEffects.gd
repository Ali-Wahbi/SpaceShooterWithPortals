extends Node


#region camera Effects
var camera: Camera2D
## total duration of the shake effect
@export var totalDuration: float = 1
## total number of loops of the shake effect
@export var totalLoops: int = 15
## strength of the shake effect
@export var strength: int = 1:
	set(value):
		strength = clamp(value, 0, 5)

## set the strength, duration and total loops of the shake effect. 0 to set to default.
func shakeCamera(_strength: int = strength, _totalDuration: float = totalDuration, _totalLoops: int = totalLoops) -> void:
	strength = strength if _strength == 0 else _strength
	totalDuration = totalDuration if _totalDuration == 0 else _totalDuration
	totalLoops = totalLoops if _totalLoops == 0 else _totalLoops

	_shakeCameraTween()


func _getRandomOffset() -> Vector2:
	return Vector2(randf_range(-strength, strength),
	randf_range(-strength, strength))


func _shakeCameraTween():
	# find the camera, else return
	if camera == null:
		camera = get_viewport().get_camera_2d()
		if camera == null:
			return
	
	var shakeTween: Tween = create_tween(
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	var duration = totalDuration / totalLoops

	for loop in totalLoops:
		shakeTween.tween_property(camera, "offset", _getRandomOffset(), duration)

	camera.offset = Vector2.ZERO
	# shakeTween.play()
#endregion 
