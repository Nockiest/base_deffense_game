class_name EnemySpawner
extends Node2D

@export var enemy_scenes: Array[PackedScene] = []  # List of possible enemies to spawn
@export var wave_interval: float = 5.0  # Interval between spawns in seconds
@export var map_bounds: Rect2  # Define your map bounds here
@export var wave_sizes:= [5,10,15,20]

var spawn_timer: Timer

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Create a timer to handle periodic enemy spawning
	spawn_timer = Timer.new()
	spawn_timer.wait_time = wave_interval
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout",  _on_spawn_timer_timeout )
	add_child(spawn_timer)
	spawn_timer.start()

# Timer timeout callback to spawn an enemy
func _on_spawn_timer_timeout() -> void:
	spawn_wave()
	
func spawn_wave():
	for wave in range(0, wave_sizes[0]):
		spawn_enemy_at_random_edge()
# Function to spawn an enemy at a random position along the map edges
func spawn_enemy_at_random_edge() -> void:
	# Ensure there are enemy scenes to spawn
	if len(enemy_scenes) == 0:
		push_error("No enemy scenes set to spawn.")
		return

	# Pick a random enemy scene from the list
	var random_enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy_instance = random_enemy_scene.instantiate()

	# Determine a random position on the map edge
	var newpos = get_random_edge_position(map_bounds)
	enemy_instance.global_position = newpos
	# Add the enemy to the scene (assumes you have a parent node like "Battleground" to organize your enemies)
	Utils.add_child_to_battleground(enemy_instance, 'Enemies')  # Adjust to your scene hierarchy

# Function to get a random position along the map edge
func get_random_edge_position(bounds: Rect2) -> Vector2:
	var side = randi() % 4  # 0 = top, 1 = right, 2 = bottom, 3 = left
	match side:
		0:  # Top edge
			return Vector2(randf() * bounds.size.x + bounds.position.x, bounds.position.y)
		1:  # Right edge
			return Vector2(bounds.position.x + bounds.size.x, randf() * bounds.size.y + bounds.position.y)
		2:  # Bottom edge
			return Vector2(randf() * bounds.size.x + bounds.position.x, bounds.position.y + bounds.size.y)
		3:  # Left edge
			return Vector2(bounds.position.x, randf() * bounds.size.y + bounds.position.y)

	return Vector2.ZERO  # Fallback, shouldn't be reached
