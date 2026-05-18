extends Node2D

@onready var hoverSFX: AudioStreamPlayer = $buttonHover
@onready var pressSFX: AudioStreamPlayer = $buttonPressed
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	spaceMouseOffset()
	pass

#region buttons
func _on_play_mouse_entered() -> void:
	hoverSFX.play()


func _on_play_pressed() -> void:
	pressSFX.play()
	animPlayer.play("hideUI")
	await animPlayer.animation_finished
	# go to main game area
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	hoverSFX.play()

func _on_quit_pressed() -> void:
	pressSFX.play()
	animPlayer.play("hideUI")
	await animPlayer.animation_finished
	get_tree().quit()
#endregion

#region space

@onready var tileMap: TileMapLayer = $StarsBg
@export var minimumOffset: Vector2
@export var maximumTileOffset: Vector2
var xOffset: float:
	set(value):
		xOffset = value
		setSpaceXOffset()
var yOffset: float:
	set(value):
		yOffset = value
		setSpaceYOffset()

func spaceMouseOffset():
	var mousePos = get_global_mouse_position() / get_viewport_rect().size - Vector2.ONE / 2.0
	if abs(mousePos.x) > minimumOffset.x:
		xOffset = mousePos.x - minimumOffset.x
	if abs(mousePos.y) > minimumOffset.y:
		yOffset = mousePos.y - minimumOffset.y
	pass

func setSpaceXOffset():
	if tileMap:
		tileMap.material.set_shader_parameter("addX", -xOffset * maximumTileOffset.x)

func setSpaceYOffset():
	if tileMap:
		tileMap.material.set_shader_parameter("addY", -yOffset * maximumTileOffset.y)
#endregion
