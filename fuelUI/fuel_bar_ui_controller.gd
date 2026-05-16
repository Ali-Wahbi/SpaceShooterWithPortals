extends Control

@onready var fuelBar: TextureProgressBar = %FuelBar
@onready var labelBehind: Label = %LabelBehind
@onready var labelFront: Label = %LabelFront

func _ready():
	modulate.a = 0.0
func setFuelUIValue(value: float) -> void:
	var intValue = roundi(value)

	if intValue == 100:
		labelBehind.text = ""
		labelFront.text = ""
	else:
		labelBehind.text = str(intValue)
		labelFront.text = str(intValue)

	fuelBar.value = value

func hideUI():
	var tween := create_tween()
	tween.tween_property(self , "modulate:a", 0.0, 0.7)

func showUI():
	var tween := create_tween()
	tween.tween_property(self , "modulate:a", 1.0, 0.7)
