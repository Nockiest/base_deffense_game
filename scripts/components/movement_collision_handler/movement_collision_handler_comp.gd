extends Node2D

@export var owner_movement_comp: MovementComponent
@export var impassable_object_groups: Array[String]

var blockingObjects: Array[Node2D] = []

func start_on_collision(area: Node2D) -> void:
	print_debug("Collision started with: ", area)
	print_debug("Current blockingObjects: ", blockingObjects)
	
	# Check if the area belongs to any of the impassable object groups
	var is_impassable = false
	for group_name in impassable_object_groups:
		if area.is_in_group(group_name):
			is_impassable = true
			break

	if is_impassable:
		# Apply a -100% modifier to speed
		owner_movement_comp.add_speed_modifier("collision", -1.0)  # -100% modifier
		if not blockingObjects.has(area):
			blockingObjects.append(area)
	else:
		print_debug(area, ' is not in any of the impassable object groups')

func stop_on_collision(area: Node2D) -> void:
	print_debug("Collision ended with: ", area)
	print_debug("Current blockingObjects: ", blockingObjects)
	
	if blockingObjects.has(area):
		blockingObjects.erase(area)
		if blockingObjects.size() == 0:
			# Remove the -100% modifier to restore base speed
			owner_movement_comp.remove_speed_modifier("collision")
		else:
			printerr('Area ', blockingObjects[0], ' still blocks', owner)
	else:
		printerr('Area ', area, ' not found in blockingObjects', owner)
