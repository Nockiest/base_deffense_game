# NearestEnemyAimingComponent.gd
class_name  EnemyAimingComponent
extends  AimingComponent

@export var enemy_group: String = "enemies"  # Group name for enemies

# Override to update the target position to the nearest enemy's position
func update_target_position() -> void:
	target_position = get_nearest_enemy_position()

# Get the position of the nearest enemy
func get_nearest_enemy_position() -> Vector2:
	var nearest_enemy_position: Vector2 = Vector2.ZERO
	var nearest_distance: float = INF

	# Get all enemies in the specified group
	var enemies = get_tree().get_nodes_in_group(enemy_group)
	
	for enemy in enemies:
		if enemy is Node2D:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_enemy_position = enemy.global_position

	return nearest_enemy_position
