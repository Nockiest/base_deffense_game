# Test script for MovementComponent using GUT
extends "res://addons/gut/test.gd"

var parent_node
var movement_component

# This function is called before each test
func before_each():
	# Create the parent node that will "own" the component
	parent_node = Node2D.new()
	parent_node.global_position = Vector2(0, 0)  # Start at origin
	
	# Add the parent node to the scene tree to avoid orphans
	add_child(parent_node)

	# Create the MovementComponent and add it as a child to the parent node
	movement_component = MovementComponent.new()
	movement_component.base_speed_px_sec = 100.0  # Set speed to 100 pixels per second
	movement_component.direction = Vector2(1, 0)  # Set direction to the right
	
	# Add the component to the parent node
	parent_node.add_child(movement_component)
	movement_component.owner = parent_node
# Test the basic functionality of the MovementComponent
func test_movement_component():
	# Simulate a single frame of movement with a given delta time
	var delta_time = 0.5  # 0.5 seconds
	movement_component._process(delta_time)
	# Assert that the parent node has moved correctly
	var expected_position = Vector2(50, 0)  # 100 px/s * 0.5s in the (1, 0) direction
	print("Position:", parent_node.global_position, "Expected:", expected_position)
	assert_eq(parent_node.global_position, expected_position, "Parent node should move correctly to the right")
	
	# Test movement in a different direction
	movement_component.direction = Vector2(0, 1)  # Set direction downwards
	movement_component._process(delta_time)
	
	# Assert the new position considering the previous movement
	expected_position = Vector2(50, 50)  # Moves another 50 pixels downward after previous movement
	print("Position after second movement:", parent_node.position, "Expected:", expected_position)
	assert_eq(parent_node.position, expected_position, "Parent node should move correctly downwards")

# This function is called after each test
func after_each():
	# Clean up nodes to avoid orphans
	if movement_component:
		movement_component.queue_free()
	if parent_node:
		parent_node.queue_free()
