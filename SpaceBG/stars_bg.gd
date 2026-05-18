extends TileMapLayer

@export_range(2, 1000, 1) var rectSizeX: int = 250
@export_range(2, 1000, 1) var rectSizeY: int = 250
var xSize = 3
var ySize = 2
var sourceID = 0
@export var chanceOfEmpty = 80
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	makeStars()

func makeStars():
	clear()
	for xCoords in range(-rectSizeX, rectSizeX):
		for yCoords in range(-rectSizeY, rectSizeY):
			if getChanceOfEmpty():
				continue
			var cellCoordinates = Vector2(xCoords, yCoords)
			var atlasCoords = Vector2(randi_range(0, xSize), randi_range(0, ySize))
			set_cell(cellCoordinates, sourceID, atlasCoords)

func getChanceOfEmpty():
	var chance = randf_range(0, 100)
	return chance < chanceOfEmpty