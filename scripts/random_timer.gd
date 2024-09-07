extends Timer

@export var min_time: float = 1.0   # Minimum time for the interval
@export var max_time: float = 5.0   # Maximum time for the interval

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Connect the timeout signal to a custom function
	connect("timeout",  _on_timeout )
	# Start the timer with a random wait time
	_set_random_wait_time()

# Function called on timeout
func _on_timeout() -> void:
	# Set the timer's wait time to a new random value within the specified range
	_set_random_wait_time()

# Set the timer's wait time to a random value within the interval [min_time, max_time]
func _set_random_wait_time() -> void:
	# Ensure min_time is less than max_time
	if min_time >= max_time:
		printerr("min_time should be less than max_time")
		return
	
	# Set the wait time to a random value between min_time and max_time
	wait_time = randf_range(min_time, max_time)
	print('new wait time is ', wait_time)
	# Restart the timer with the new wait time
	start()
