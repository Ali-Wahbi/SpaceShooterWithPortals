extends Node2D

@onready var hoverSFX: AudioStreamPlayer = $buttonHover
@onready var pressSFX: AudioStreamPlayer = $buttonPressed
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	spaceMouseOffset()

#region buttons
func _on_play_mouse_entered() -> void:
	if not animPlayer.is_playing():
		hoverSFX.play()

func _on_play_pressed() -> void:
	pressSFX.play()
	animPlayer.play("hideUI")
	await animPlayer.animation_finished
	await get_tree().create_timer(1).timeout
	# go to main game area
	get_tree().change_scene_to_file("res://mainGameArea.tscn")

func _on_quit_mouse_entered() -> void:
	if not animPlayer.is_playing():
		hoverSFX.play()

func _on_quit_pressed() -> void:
	pressSFX.play()
	animPlayer.play("hideUI")
	await animPlayer.animation_finished
	await get_tree().create_timer(1).timeout
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

var prevMousePos: Vector2 = - Vector2(1000, 1000)
func spaceMouseOffset():
	var mousePos = get_global_mouse_position() / get_viewport_rect().size - Vector2.ONE / 2.0
	if prevMousePos == mousePos:
		return
	prevMousePos = mousePos
	if abs(mousePos.x) > minimumOffset.x:
		xOffset = mousePos.x - minimumOffset.x
	if abs(mousePos.y) > minimumOffset.y:
		yOffset = mousePos.y - minimumOffset.y

func setSpaceXOffset():
	if tileMap:
#		Change offset using shader
		tileMap.material.set_shader_parameter("addX", -xOffset * maximumTileOffset.x)
#		Change offset using position
		#tileMap.position.x = -xOffset * maximumTileOffset.x
func setSpaceYOffset():
	if tileMap:
#		Change offset using shader
		tileMap.material.set_shader_parameter("addY", -yOffset * maximumTileOffset.y)
#		Change offset using position
		#tileMap.position.y = -yOffset * maximumTileOffset.y
#endregion
