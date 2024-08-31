class_name MovementCollisionHandlerComp
extends NodeModClass

func get_type_name():
	return 'MovementCollisionHandlerComp'

@export var owner_movement_comp:MovementComponent
@export var impassable_object_groups:Array[String]

var blockingObjects:Array[Node2D]
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
		owner_movement_comp.speed_px_sec = 0
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
			owner_movement_comp.speed_px_sec = owner_movement_comp.base_speed_px_sec
		else:
			printerr('area ', blockingObjects[0], ' still blocks', owner)
	else:
		printerr('area ', area, ' not found in blockingObjects', owner)
