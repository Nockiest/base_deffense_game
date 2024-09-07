extends Node2D

@export var owner_movement_comp: MovementComponent
@export var impassable_object_groups: Array[String]

var blockingObjects: Array[Node2D] = []
var collision_effect = preload('res://scenes/effects/colliison_effect/collision_effect.tscn')
var collision_instance:CollisionEffect
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
		prints( "adding child ",owner, owner_movement_comp.effect_hold_component, collision_effect)
		collision_instance = collision_effect.instantiate()
		owner_movement_comp.effect_hold_component.add_child(collision_instance)  # -100% modifier
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
			owner_movement_comp.effect_hold_component.remove_child(collision_instance)
		else:
			push_error('Area ', blockingObjects[0], ' still blocks', owner)
	else:
		push_error('Area ', area, ' not found in blockingObjects', owner)
