class_name MomvementComponent
extends Node

@export var valid_directions: Array[DirectionList.Direction] # ['left', 'right', 'down', 'up', 'up-left', 'up-right', 'down-left', 'down-right']
@export var valid_movement_patterns: Array[Vector2i]  # Define the array with valid vectors
@export var valid_max_movement_range: float = 1  # Define the maximum movement range
signal moved(from, to)
func process_movement(from, to):
 
	
	var validation_input_data = {
		"valid_directions": valid_directions,
		"valid_movement_patterns": valid_movement_patterns,
		"valid_max_movement_range": valid_max_movement_range
	}
	print("Received movement to", from, to, $MovementValidator.validate_move(from, to, validation_input_data))
	if $MovementValidator.validate_move(from, to, validation_input_data):
		print("Move would be valid")
		emit_signal("moved", from,to)
		Utils.find_ancestor_by_factor(4,owner).move_entity_to_validated_position(from, to, owner)
#func move_entity_to_new_cell_container(new_entity_container_coors: Vector2i):
#	# this function processes already validated moves
#	if new_entity_container_coors == owner.MovementComponent:
#		printerr("you want to move to the same position as before")
#		return
#	# Get the current parent
#	var current_parent = owner.get_parent()
#	var tiles = get_tree().get_nodes_in_group("tiles")
#	# Check if the new parent is valid and different from the current parent
#	for tile in tiles:
#		if tile.position_tracker.get_grid_position() == new_entity_container_coors:
#			print("found the correct tile ",tile.position_tracker.get_grid_position() , tile.position_tracker.get_grid_position() == new_entity_container_coors)
#			owner.get_parent().remove_child_node(self)
#			tile.get_node("EntityContainer").recieve_child_node(owner)
#
#		# Remove from current parent
#	current_position_tracker.set_grid_position(new_entity_container_coors)
		
 
