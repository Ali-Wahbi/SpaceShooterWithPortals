extends Node

@export var fuelUI: Control
@export var player: CharacterBody2D
@export var instructions: Node2D
@export var startTimer = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(startTimer).timeout
	showFuelUI()
	allowPlayerMovement()
	hideInstructions()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func showFuelUI():
	if fuelUI:
		fuelUI.showUI()

func hideFuelUI():
	if fuelUI:
		fuelUI.hideUI()

func allowPlayerMovement():
	if player:
		player.canMove = true

func hideInstructions():
	if instructions:
		instructions.visible = false
