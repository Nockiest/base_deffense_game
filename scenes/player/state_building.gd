extends State

var selectedBuilding:PackedScene:
	set(value):
		$"../../CursorHolder".insert_scene(value)
		selectedBuilding = value 

func enter(msg:={} ):
	print('msg',msg)
	if 'selectedBuilding' in msg.keys():
		selectedBuilding = msg['selectedBuilding']
	else:
		printerr('selected building not defined', msg)

func _on_node_clicked(node: Node) -> void:
	print("player clicked while in building mode")

func  on_construction_bar_clicked(node_packed: PackedScene) :
	print(selectedBuilding ==node_packed)
	if selectedBuilding ==node_packed:
		state_machine.transition_to('Basic')
		
# Function to switch to the Building state
