# TestMine.gd
extends "res://addons/gut/test.gd"
@onready var mine_scene = preload("res://scenes/mine/gold_mine.tscn")

var resource_collected = false
var collected_amount = 0

# Test setup
func _before_each():
	# Instantiate the mine scene
	var mine = mine_scene.instance()
	add_child(mine)
	#yield(get_tree(), "idle_frame")  # Allow time for the scene tree to update
	resource_collected = false
	collected_amount = 0

func test_collect_resource_on_click():
	# Arrange
	var mine = GoldMine.new()
	add_child(mine)
	#yield(get_tree(), "idle_frame")
	
	
	## Connect the signal to verify if resources are collected
	#mine.connect("resource_collected",  _on_resource_collected )
	
	# Act
	# Simulate a left mouse button click on the mine's position
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = true
	event.position = mine.global_position  # Assuming you are clicking directly on the mine
	mine._input(event)
	
	
	assert_true(resource_collected, "Resource should be collected on left mouse click.")
	assert_eq (collected_amount, mine.gold_per_click, "Collected amount should match the mine's resource amount.")

# Helper function to handle signal emission
#func _on_resource_collected(amount: int):
	#resource_collected = true
	#collected_amount += amount
func test_no_resource_on_right_click():
	# Arrange
	var mine = GoldMine.new()
	add_child(mine)
	#yield(get_tree(), "idle_frame")
	
	var resource_collected = false
	
	# Connect the signal to verify if resources are collected
	#mine.connect("resource_collected", _on_resource_collected )
	
	# Act
	# Simulate a right mouse button click on the mine's position
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_RIGHT
	event.pressed = true
	event.position = mine.global_position
	mine._input(event)
	
	#yield(get_tree(), "idle_frame")  # Allow time for processing
	
	# Assert
	assert_false(resource_collected, "Resource should not be collected on right mouse click.")

# More tests can be added as needed, for example:
# - Click outside the mine's collision area.
# - Test different `resource_amount` values.
# - Verify multiple clicks add resources correctly.
