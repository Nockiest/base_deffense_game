class_name Player
extends Node2D

var gold: int
var click_power: float = 1

func _input(event: InputEvent) -> void:
	# Check if the input event is a mouse button press and if it's the left button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Get the global mouse position
		var mouse_position = get_global_mouse_position()
		
		# Define a small circle shape at the mouse position
		var circle_shape = CircleShape2D.new()
		circle_shape.radius = 1.0  # Very small radius to simulate a point

		# Setup the query parameters with the circle shape
		var query = PhysicsShapeQueryParameters2D.new()
		query.shape = circle_shape
		query.transform = Transform2D(0, mouse_position)  # Place the circle at the mouse position
		query.collide_with_areas = true
		query.collide_with_bodies = true

		# Perform the shape intersection query
		var space_state = get_world_2d().direct_space_state
		var results = space_state.intersect_shape(query, 1)  # Maximum 1 result
		
		# Check if a node was found
		if results.size() > 0:
			var clicked_node = results[0].collider  # Get the node (collider) that was clicked
			print("Clicked node:", clicked_node.name)

			# Perform actions based on the clicked node
			_on_node_clicked(clicked_node)

# Handle the clicked node
func _on_node_clicked(node: Node) -> void:
	# Example action when a node is clicked
	if node is GoldMine:
		var recource = node. provide_recource()
		var treasury = get_tree().get_first_node_in_group("treasury")
		treasury.gold += round(recource*click_power)
	print("Node clicked:", node.name)
	# Add logic here for what should happen when the node is clicked
