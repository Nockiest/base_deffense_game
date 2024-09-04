extends State

# Handle the clicked node
func _on_node_clicked(node: Node) -> void:
	# Example action when a node is clicked
	if node is GoldMine:
		var recource = node. provide_recource()
		var treasury = get_tree().get_first_node_in_group("treasury")
		treasury.gold += round(recource*owner.click_power)
	# Add logic here for what should happen when the node is clicked
	# Handle other nodes
	else:
		print("Node clicked:", node.name)

# Helper function to determine if the node is the ConstructionBar or a child of it
func  on_construction_bar_clicked(node: PackedScene) :
	state_machine.transition_to('Building')

# Function to switch to the Building state

	
