class_name BattleGround
extends Node2D


 
func wait_for_seconds(seconds: float) -> void:
	# Create a Timer node
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)  # Add the timer to the current node
	timer.start()     # Start the timer

	# Wait until the timer emits the 'timeout' signal
	await timer.timeout

	# Code after the delay
	print("3 seconds have passed, continuing execution")
 

func _ready() -> void:
	# Call the wait function
	wait_for_seconds(3.0)  # Waits for 3 seconds before continuing
