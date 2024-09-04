class_name CursorHolder
extends Node2D

# Sprite2D node to display the current sprite of the packed scene
@onready var sprite: Sprite2D = $Sprite2D  # Make sure to add a Sprite2D as a child node in the scene

# Function to insert a packed scene and display its sprite
func insert_scene(packed_scene: PackedScene) -> void:
	print('inserting scene:', packed_scene)
	# Instance the packed scene
	var instance = packed_scene.instantiate()
	# Ensure the scene has a Sprite2D as a child
	var scene_sprite: Sprite2D = instance.get_node_or_null("Sprite2D")
	
	if scene_sprite:
		# Assign the sprite texture from the scene to the cursor holder's sprite
		sprite.texture = scene_sprite.texture
		# Optionally, copy other sprite properties (like modulate, scale, etc.)
		sprite.modulate = scene_sprite.modulate
		sprite.scale = scene_sprite.scale
	else:
		printerr("Packed scene does not contain a Sprite2D node.")

# Function to update the cursor holder's position to follow the mouse cursor
func _process(delta: float) -> void:
	# Update the position to follow the global mouse position
	position = get_global_mouse_position()


 
