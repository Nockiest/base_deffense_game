## not nested
# HighestConcentrationAimingComponent.gd
class_name CrowdAimingComponent
extends  AimingComponent

@export var concentration_radius: float = 100.0  # Radius for concentration calculation

# Override to update the target position to the highest concentration position
func update_target_position() -> void:
	target_position = get_highest_concentration_position()

# Get the position of the highest concentration of nodes within a radius
func get_highest_concentration_position() -> Vector2:
	var highest_concentration_position: Vector2 = Vector2.ZERO
	var highest_concentration: int = 0

	# Check all nodes in the scene within the specified radius
	var nodes_in_range = get_tree().get_nodes_in_group("scene_objects")
	for node in nodes_in_range:
		if node is Node2D:
			var distance = global_position.distance_to(node.global_position)
			if distance <= concentration_radius:
				var concentration = count_neighbors(node)
				if concentration > highest_concentration:
					highest_concentration = concentration
					highest_concentration_position = node.global_position

	return highest_concentration_position

# Helper function to count neighboring nodes (for concentration calculation)
func count_neighbors(node: Node2D) -> int:
	var count = 0
	var nodes_in_range = get_tree().get_nodes_in_group("scene_objects")
	for other_node in nodes_in_range:
		if other_node is Node2D and other_node != node:
			if node.global_position.distance_to(other_node.global_position) <= concentration_radius:
				count += 1
	return count
