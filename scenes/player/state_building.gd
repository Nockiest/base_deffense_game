extends State


 
 
#func exit():
	#$"../../ItemPlacer".remove_scene()
func _on_node_clicked(_node: Node) -> void:
	pass
 
func  on_construction_bar_clicked(node_packed: PackedScene) :
	owner.building_to_place_changed.emit(node_packed)

func _on_item_placer_placable_instance_changed(placable_instance: Placable) -> void:
	if not placable_instance and state_machine.state == self:
		state_machine.transition_to('Basic')

# Input handler for the state
func _input(event: InputEvent) -> void:
	# Check if the input event is a mouse button event and if it's the right mouse button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		state_machine.transition_to('Basic')
