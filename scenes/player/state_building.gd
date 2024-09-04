extends State

var selectedBuilding:PackedScene:
	set(value):
		if value:
			$"../../CursorHolder".insert_scene(value)
		else:
			$"../../CursorHolder".remove_scene( )
		selectedBuilding = value 

func enter(msg:={} ):
	print('msg',msg)
	if 'selectedBuilding' in msg.keys():
		selectedBuilding = msg['selectedBuilding']
	else:
		printerr('selected building not defined', msg)

	
func _on_node_clicked(node: Node) -> void:
	if not node:
		# Instantiate the building from the selectedBuilding PackedScene
		var new_building = selectedBuilding.instantiate()
		# Set the global position of the new building to the mouse position
		new_building.global_position = owner.get_global_mouse_position()
		Utils.add_child_to_battleground(new_building, 'Buildings')
		
		selectedBuilding = null
		state_machine.transition_to('Basic')

func  on_construction_bar_clicked(node_packed: PackedScene) :
	print(selectedBuilding ==node_packed)
	if selectedBuilding ==node_packed:
		state_machine.transition_to('Basic')
		
# Function to switch to the Building state
