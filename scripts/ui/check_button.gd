class_name SpeedUpButton
extends Button

# Speed multipliers
@export var normal_speed: float = 1.0  # Normal game speed
@export var fast_speed: float = 2.0    # Fast game speed
@export var is_fast: bool = false      # Flag to track speed state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the button's pressed signal to a function
	connect("pressed",  _on_button_pressed )
	update_button_text()

# Function to toggle game speed
func _on_button_pressed() -> void:
	# Toggle the speed state
	is_fast = !is_fast
	
	# Set the engine's time scale based on the state
	Engine.time_scale = fast_speed if is_fast else normal_speed
	print("Game speed set to: ", Engine.time_scale)

	# Update the button text
	update_button_text()

# Updates the button text based on the current speed state
func update_button_text() -> void:
	text = "Speed Up" if not is_fast else "Normal Speed"
