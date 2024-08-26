extends Node2D
# TO DO enable highest_concentration
class_name AimingComponent

# Enum to define the targeting modes
enum TargetingMode {
	MOUSE,
	NEAREST_ENEMY,
	#HIGHEST_CONCENTRATION
}

@export var targeting_mode: TargetingMode = TargetingMode.MOUSE  # Default to aiming at mouse position
@export var enemy_group: String = "enemies"  # Group name for enemies
#@export var concentration_radius: float = 100.0  # Radius for concentration calculation

var target_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_target_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_target_position()

# Update the target position based on the selected targeting mode
func update_target_position() -> void:
	match targeting_mode:
		TargetingMode.MOUSE:
			target_position = get_global_mouse_position()
		TargetingMode.NEAREST_ENEMY:
			target_position = get_nearest_enemy_position()
		#TargetingMode.HIGHEST_CONCENTRATION:
			#target_position = get_highest_concentration_position()

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

## Get the position of the highest concentration of scenes within a radius
#func get_highest_concentration_position() -> Vector2:
	#var highest_concentration_position: Vector2 = Vector2.ZERO
	#var highest_concentration: int = 0
#
	## Check all nodes in the scene within the specified radius
	#var nodes_in_range = get_tree().get_nodes_in_group("scene_objects")
	#for node in nodes_in_range:
		#if node is Node2D:
			#var distance = global_position.distance_to(node.global_position)
			#if distance <= concentration_radius:
				#var concentration = count_neighbors(node)
				#if concentration > highest_concentration:
					#highest_concentration = concentration
					#highest_concentration_position = node.global_position
#
	#return highest_concentration_position

# Helper function to count neighboring nodes (for concentration calculation)
#func count_neighbors(node: Node2D) -> int:
	#var count = 0
	#var nodes_in_range = get_tree().get_nodes_in_group("scene_objects")
	#for other_node in nodes_in_range:
		#if other_node is Node2D and other_node != node:
			#if node.global_position.distance_to(other_node.global_position) <= concentration_radius:
				#count += 1
	#return count
