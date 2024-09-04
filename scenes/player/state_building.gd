extends State

var selectedBuilding:PackedScene

func _on_node_clicked(node: Node) -> void:
	print("player clicked while in building mode")

func  on_construction_bar_clicked(node: PackedScene) :
	print(selectedBuilding ==node)
	if selectedBuilding ==node:
		state_machine.transition_to('Basic')

# Function to switch to the Building state
