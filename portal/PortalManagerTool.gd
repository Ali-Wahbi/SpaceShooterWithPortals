@tool
class_name PortalManagerTool
extends EditorScript

var window: Window
var portalLabel1: Label
var portalLabel2: Label

var connectPortalsButton: Button

var editorSelection: EditorSelection

# Called when the node enters the scene tree for the first time.
func _run() -> void:
	editorSelection = EditorInterface.get_selection()
	editorSelection.selection_changed.connect(updateLabels)
	
	window = Window.new()
	window.always_on_top = true
	window.transient = false
	EditorInterface.popup_dialog(window, Rect2(Vector2(1100, 100), Vector2(420, 180)))

	makeGUI()
	updateLabels()
	window.close_requested.connect(func():
		window.queue_free()
		)

func makeGUI():
	var hBox = HBoxContainer.new()
	var vBox = VBoxContainer.new()

	hBox.custom_minimum_size = Vector2(400, 100)
	vBox.custom_minimum_size = Vector2(200, 100)
	

	portalLabel1 = Label.new()
	portalLabel1.size_flags_horizontal = Control.SIZE_EXPAND
	portalLabel1.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	portalLabel2 = Label.new()
	portalLabel2.size_flags_horizontal = Control.SIZE_EXPAND
	portalLabel2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	connectPortalsButton = Button.new()
	connectPortalsButton.text = "Connect Portals"
	connectPortalsButton.size_flags_horizontal = Control.SIZE_EXPAND
	connectPortalsButton.disabled = not editorSelection.get_selected_nodes().size() == 2
	connectPortalsButton.pressed.connect(onConnectPressed)


	window.add_child(hBox)
	hBox.add_child(vBox)
	hBox.add_child(connectPortalsButton)

	vBox.add_child(portalLabel1)
	vBox.add_child(portalLabel2)
	# window.add_child(connectPortalsButton)
	hBox.position = Vector2(20, 40)
	portalLabel1.text = "Not Selected"
	portalLabel2.text = "Not Selected"

func updateLabels():
	var allNodes = editorSelection.get_selected_nodes()

	if not allNodes.is_empty():
		var node0 = allNodes[0]
		portalLabel1.text = "Portal 1: " + node0.name if node0 is Portal else node0.name + ": Not a Portal"

		if allNodes.size() > 1:
			var node1 = allNodes[1]
			portalLabel2.text = "Portal 2: " + node1.name if node1 is Portal else node1.name + ": Not a Portal"
		else:
			portalLabel2.text = "Not Selected"
		
		connectPortalsButton.disabled = not editorSelection.get_selected_nodes().size() == 2
	else:
		portalLabel1.text = "Not Selected"
		portalLabel2.text = "Not Selected"
		connectPortalsButton.disabled = true
	print("Selection Changed")

func onConnectPressed():
	var allNodes = editorSelection.get_selected_nodes()
	var portal1: Portal = allNodes[0]
	var portal2: Portal = allNodes[1]

	portal1.otherPortal = portal2
	portal2.otherPortal = portal1