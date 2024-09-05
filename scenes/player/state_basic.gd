extends State

# Handle the clicked node
func _on_node_clicked(node: Node) -> void:
	# Example action when a node is clicked
	if node is GoldMine:
		var recource = node. provide_recource()
		Globals.gold += round(recource*owner.click_power)
	# Add logic here for what should happen when the node is clicked
	# Handle other nodes
	else:
		if node:
			print("Node clicked:",node.name)
		else:
			print("Node clicked:", node )
			

# Helper function to determine if the node is the ConstructionBar or a child of it
func  on_construction_bar_clicked(node: PackedScene) :
	var msg:Dictionary = { 'selectedBuilding': node}
	var node_instance = node.instantiate()
	if node_instance.can_afford_build():
		owner.building_to_place_changed.emit(node)
		state_machine.transition_to('Building', msg  ) 
	else:
		printerr('cant afford to build building:', node)

# Function to switch to the Building state

	
