extends "res://addons/gut/test.gd"

var _level
var _turret
var _sender = InputSender.new()

func before_each():
	# Load and add the Battleground scene
	_level = Node2D.new() #add_child_autofree(BattleGround.new())
	_turret = double(Turret).new()
	add_child_autofree(_level)
	_level.add_child(_turret)
	print('hello')
	# Ensure that the scene is properly ready
	#await _level.ready

func after_each():
	_sender.release_all()
	_sender.clear()

func _test_mouse_click():
	# Ensure the turret is valid
	Test.mock_properties(_turret)
	
	assert_not_null(_turret, "Turret node should be found in the scene.")
	
func _test_something():
	# Ensure the turret is valid
	assert_true(true, "Turret node should be found in the scene.")


	# Get the global position of the turret for the click simulation
	var mouse_position = _turret.global_position
	
	# Simulate a left mouse click at the position of the turret
	_simulate_mouse_click(mouse_position)
	
	# Wait for the click to be processed
	await get_tree().idle_frame
	
	# Check if the turret has been interacted with
	# This assumes the turret has a method or signal indicating it was clicked
	assert_true(_turret.clicked, "Turret should have been clicked.")

func _simulate_mouse_click(position):
	# Create a new input event for the left mouse button
	_sender.action_down("MOUSE_BUTTON_LEFT").hold_for(.1)
 
