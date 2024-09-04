extends State

var selectedBuilding:PackedScene

func _on_node_clicked(node: Node) -> void:
	print("player clicked while in building mode")

func  on_construction_bar_clicked(node_packed: PackedScene) :
	print(selectedBuilding ==node_packed)
	if selectedBuilding ==node_packed:
		state_machine.transition_to('Basic')
		$"../../CursorHolder".insert_scene(node_packed)
# Function to switch to the Building state
