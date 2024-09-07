class_name Player
extends Node2D

var gold: int
var click_power: float = 1
#signal building_to_place_changed(building:PackedScene)

@export var item_placer:ItemPlacer
func _ready() -> void:
	# Connect to the group "ConstructionButtons" to listen for button press signals
	for button in get_tree().get_nodes_in_group("ConstructionButtons"):
		button.connect("pressedConstructionButton", _on_construction_button_pressed )
		
func _input(event: InputEvent) -> void:
	# Check if the input event is a mouse button press and if it's the left button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Get the global mouse position
		var mouse_position = get_global_mouse_position()
		var results = get_bodies_on_position(mouse_position)
		var clicked_node:Node2D
		# Check if a node was found
		if results.size() > 0:
			clicked_node = results[0].collider  # Get the node (collider) that was clicked
			print("Clicked node:", clicked_node.name)

			# Perform actions based on the clicked node
		$StateMachine.state._on_node_clicked(clicked_node)
		 
func _on_construction_button_pressed(constructed_entity: PackedScene) -> void:
	$StateMachine.state.on_construction_bar_clicked(constructed_entity)
	# Handle construction logic here (e.g., placing a turret or mine)

func get_bodies_on_position(target:Vector2)->Array[Dictionary]:
		# Define a small circle shape at the mouse position
		var circle_shape = CircleShape2D.new()
		circle_shape.radius = 1.0  # Very small radius to simulate a point

		# Setup the query parameters with the circle shape
		var query = PhysicsShapeQueryParameters2D.new()
		query.shape = circle_shape
		query.transform = Transform2D(0, target)  # Place the circle at the mouse position
		query.collide_with_areas = true
		query.collide_with_bodies = true

		# Perform the shape intersection query
		var space_state = get_world_2d().direct_space_state
		var results = space_state.intersect_shape(query, 1)  # Maximum 1 result
		return results
