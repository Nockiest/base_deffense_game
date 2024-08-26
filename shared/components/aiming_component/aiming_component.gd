class_name AimingComponent
extends Node2D
#used to give parrent a position to aim at

# Variable to store the current mouse position
var mouse_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the mouse position
	mouse_position = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update the mouse position every frame
	mouse_position = get_global_mouse_position()
