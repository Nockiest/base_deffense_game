class_name EnemyAimingComponent
extends AimingComponent

## TO DO make it an array
@export var enemy_group: String    # Group name for enemies

# Variable to store the currently aimed-at enemy
var current_target: Node2D = null:
	set(value):
		if current_target != value:
			current_target = value
			emit_signal("target_changed", value)


signal target_changed(target: Node2D)
# Override to update the target position to the nearest enemy's position

func update_target_position() -> void:
	current_target = get_nearest_enemy()
	if current_target:
		target_position = current_target.global_position

# Get the nearest enemy and store it
func get_nearest_enemy() -> Node2D:
	if   enemy_group == "" :
		printerr("enemy group not set")
	var nearest_enemy: Node2D = null
	var nearest_distance: float = INF

	# Get all enemies in the specified group
	var enemies = get_tree().get_nodes_in_group(enemy_group)

	for enemy in enemies:
		if enemy is Node2D:
			# Check if the enemy node is still in the scene tree
			if not enemy.is_inside_tree():
				continue

			var distance = global_position.distance_to(enemy.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_enemy = enemy

	return nearest_enemy
