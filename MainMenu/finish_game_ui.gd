extends Control

@onready var hoverSFX: AudioStreamPlayer = $buttonHover
@onready var pressSFX: AudioStreamPlayer = $buttonPressed


@onready var quitButton: Button = $MarginContainer/CenterContainer/HBoxContainer/quit
@onready var quitLabel: Label = $MarginContainer/CenterContainer/HBoxContainer/quit/quitLabel
@onready var retryButton: Button = $MarginContainer/CenterContainer/HBoxContainer/retry
@onready var retryLabel: Label = $MarginContainer/CenterContainer/HBoxContainer/retry/retryLabel
var isChanging: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("Pause") and not isChanging:
		if visible:
			get_tree().paused = false
			visible = false
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		else:
			get_tree().paused = true
			visible = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
func _on_restart_pressed() -> void:
	if isChanging:
		return
	pressSFX.play()
	isChanging = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_restart_mouse_entered() -> void:
	hoverSFX.play()
	retryLabel.visible = true


func _on_restart_mouse_exited() -> void:
	retryLabel.visible = false


func _on_quit_pressed() -> void:
	if isChanging:
		return
	pressSFX.play()
	isChanging = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")

func _on_quit_mouse_entered() -> void:
	hoverSFX.play()
	quitLabel.visible = true

func _on_quit_mouse_exited() -> void:
	quitLabel.visible = false
