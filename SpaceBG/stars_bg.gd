extends TileMapLayer

var rectSize = 250
var xSize = 3
var ySize = 2
var sourceID = 0
@export var chanceOfEmpty = 80
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	makeStars()

func makeStars():
	clear()
	for xCoords in range(-rectSize, rectSize):
		for yCoords in range(-rectSize, rectSize):
			if getChanceOfEmpty():
				continue
			var cellCoordinates = Vector2(xCoords, yCoords)
			var atlasCoords = Vector2(randi_range(0, xSize), randi_range(0, ySize))
			set_cell(cellCoordinates, sourceID, atlasCoords)

func getChanceOfEmpty():
	var chance = randf_range(0, 100)
	return chance < chanceOfEmpty