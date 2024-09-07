class_name ItemPlacer
extends Node2D

var placable_instance: Placable:
	set(value):
		print(placable_instance, ' changing to ', value)
		placable_instance = value
		placable_instance_changed.emit(value)
		
var preview_instance: PlacablePreview

signal placable_instance_changed(placable_instance:Placable)
signal invalid_placement(placable_instance:Placable)
# Function to insert a packed scene and display its sprite
func insert_scene(packed_scene: PackedScene) -> void:
	print('Inserting scene:', packed_scene)
	_create_placement_preview(packed_scene)

# Function to remove the scene and clear the preview
func remove_scene():
	placable_instance = null
	if preview_instance:
		remove_child(preview_instance)
		preview_instance = null

# Function to update the cursor holder's position to follow the mouse cursor
func _process(_delta: float) -> void:
	# Update the position to follow the global mouse position
	global_position = get_global_mouse_position()

# Function to create a placement preview of the packed scene
func _create_placement_preview(packed_scene: PackedScene):
	placable_instance = packed_scene.instantiate() as Placable
	var preview = load(placable_instance.placable_scene_to_load_path)
	print(placable_instance.placable_scene_to_load_path)
	if not preview:
		push_error('preview not defined ', preview, placable_instance)
		return
	preview_instance = preview.instantiate()
	add_child(preview_instance)

# Function to handle input events
func _input(event: InputEvent) -> void:
	# Check if the left mouse button was pressed
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Check if the preview instance can be placed
			if preview_instance :
				print(preview_instance , preview_instance.can_place)
			
				if preview_instance.can_place:
					place_scene()
			else:
				print("Cannot place the scene here.", preview_instance , )
				if preview_instance:
					print(preview_instance.get('can_place'))

# Function to place the scene into the world
func place_scene():
	if not placable_instance:
		return

	# Instantiate the placable scene and set its position
	var new_instance = placable_instance 
	new_instance.global_position = get_global_mouse_position()

	# Add the new instance to the world (adjust this to fit your scene hierarchy)
	#get_parent().add_child(new_instance)
	Utils.add_child_to_battleground(new_instance, 'Buildings')
	# Clear the current placement
	remove_scene()
	print("Scene placed into the world.")

 


func _on_player_building_to_place_changed(building: PackedScene) -> void:
	insert_scene(building)
