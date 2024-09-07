class_name PlayerFightingState
extends State

# Handle the clicked node
func _on_node_clicked(node: Node) -> void:
	if not node:
		return
	if node.has_method('respond_to_click'):
		node.respond_to_click(owner.click_power)

# Helper function to determine if the node is the ConstructionBar or a child of it
func  on_construction_bar_clicked(node: PackedScene) :
	var msg:Dictionary = { 'selectedBuilding': node}
	var node_instance = node.instantiate()
	
	if node_instance.can_afford_build():
		owner.building_to_place_changed.emit(node)
		state_machine.transition_to('Building', msg  ) 
	else:
		push_error('cant afford to build building:', node)

# Function to switch to the Building state

	
