class_name EntityAimingComponent
extends AimingComponent

@export var enemy_group: String  # Group name for enemies
@export var range_px: float = INF  # Maximum range to detect enemies
signal target_changed(target: Node2D)

# Variable to store the currently aimed-at enemy
var current_target: Node2D = null:
	set(value):
		if current_target != value:
			print_rich('[b]current target is[/b]', current_target)
			current_target = value
			target_changed.emit(value)

# Override to update the target position to the nearest enemy's position
func update_target_position() -> void:
	current_target = get_nearest_enemy(enemy_group)
	if current_target and is_instance_valid(current_target):
		target_position = current_target.global_position
	elif owner != null:
		current_target = null
	else:
		push_error("owner not set")

# Get the nearest enemy within the specified range and store it
func get_nearest_enemy(group_of_enemies: String, includeOwner: bool = false) -> Node2D:
	# Check if the enemy group is set and not null
	if group_of_enemies == "" or group_of_enemies == null:
		oneErr.print_once('group_of_enemies_null', ["Error: Enemy group not set or is null"])
		return null  # Return null explicitly in error cases

	var nearest_enemy: Node2D = null
	var nearest_distance: float = range_px  # Limit search to within range

	# Attempt to retrieve all enemies in the specified group
	var enemies = []
	if get_tree() != null:
		enemies = get_tree().get_nodes_in_group(group_of_enemies)
	else:
		push_error("Error: Unable to access the scene tree.")
		return null  # Return early if the scene tree is not accessible

	# Iterate through the enemies and find the nearest one within the specified range
	for enemy in enemies:
		if not includeOwner and enemy == owner:
			continue
		if enemy is Node2D:
			var distance = global_position.distance_to(enemy.global_position)
			# Check if the enemy is within the specified range
			if distance < nearest_distance and distance <= range_px:
				nearest_distance = distance
				nearest_enemy = enemy

	# If no enemies were found or the group was empty, log an error
	if nearest_enemy == null:
		oneErr.print_once('targets not found', ["Warning: No enemies found in the group: ", group_of_enemies])

	return nearest_enemy
