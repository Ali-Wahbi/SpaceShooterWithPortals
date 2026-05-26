extends Control

@onready var fuelBar: TextureProgressBar = %FuelBar
@onready var labelBehind: Label = %LabelBehind
@onready var labelFront: Label = %LabelFront

@onready var warningLabel: Label = %WarningLabel
var warningValue = 20
var warningTween: Tween
var outOfFuel = "Out Of Fuel"
var lowFuel = "Low Fuel"
func _ready():
	modulate.a = 0.0
	warningLabel.modulate.a = 0.0
func setFuelUIValue(value: float) -> void:
	var intValue = roundi(value)

	if intValue == 100:
		labelBehind.text = ""
		labelFront.text = ""
	else:
		labelBehind.text = str(intValue)
		labelFront.text = str(intValue)

	fuelBar.value = value
	if intValue == 0:
		print("Out of Fuel")
		await stopFlashModulateLabel()
		warningLabel.modulate.a = 1.0
		warningLabel.text = outOfFuel
		return
	if not warningTween and intValue <= warningValue:
		warningLabel.text = lowFuel
		flashModulateLabel()
	elif intValue > warningValue:
		stopFlashModulateLabel()


func hideUI():
	var tween := create_tween()
	tween.tween_property(self , "modulate:a", 0.0, 0.7)

func showUI():
	var tween := create_tween()
	tween.tween_property(self , "modulate:a", 1.0, 0.7)

func flashModulateLabel():
	print("Flash Tween Started")
	warningTween = create_tween().set_loops()
	warningTween.tween_property(warningLabel, "modulate:a", 1.0, 0.7)
	warningTween.tween_property(warningLabel, "modulate:a", 0.0, 0.3)

func stopFlashModulateLabel():
	if not warningTween:
		return
	print("Flash Tween Stopped")
	await warningTween.loop_finished
	if warningTween:
		warningTween.kill()
	warningTween = null
