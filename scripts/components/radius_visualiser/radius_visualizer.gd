# RadiusVisualizer.gd
class_name RadiusVisualizer
extends Node2D

var radius_px: float = 100.0   # Default radius_px of the ring
@export var ring_color: Color = Color(1, 0, 0, 0.75)  # Default color of the ring (red)
@export var filled: bool = false  # Whether the ring should be filled
@export var opacity: float = 0.75:
	set(value):
		opacity = clamp(value, 0.0, 1.0)  # Clamp opacity between 0 and 1
		ring_color.a = opacity

var time_left: float = 0.0  # Time left for the ring to be visible

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	hide()  # Start with the ring hidden

# Called every frame to update the ring's visibility and timer
func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		show()  # Show and redraw the ring every frame
	else:
		hide()  # Hide the ring after the duration ends

# Draws the ring with the specified radius_px, color, fill, and opacity
func _draw() -> void:
	if time_left > 0:
		# Correct radius usage
		draw_circle(Vector2.ZERO, radius_px, ring_color)  # Correct radius, not half

# Function to start the display of the ring
func start_display(radius: float, duration: float, parent_scale: Vector2=Vector2(1,1)) -> void:
	# Adjust the radius based on the average scale of the parent
	var average_scale = (parent_scale.x + parent_scale.y) / 2
	radius_px = radius / average_scale  # Scale the radius inversely to the parent's scale
	time_left = duration  # Set the display duration
	show()  # Show the ring
