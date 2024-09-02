class_name RadiusVisualizer
extends Node2D

@export var radius_px: float = 100.0  # The radius_px of the ring
@export var duration: float = 2.0  # Time (in seconds) the ring will be visible
@export var ring_color: Color = Color(1, 0, 0, 1)  # Default color of the ring (red)
@export var filled: bool = false  # Whether the ring should be filled
@export var opacity: float = 0.75:
	set(value):
		opacity =  clamp(value, 0.0, 1.0) # Opacity of the ring (1.0 = fully opaque, 0.0 = fully transparent)
		ring_color.a = opacity
var time_left: float = 0.0  # Time left for the ring to be visible

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Start with the ring hidden
	hide()

# Function to start showing the ring
func _show_ring() -> void:
	time_left = duration
	show()  # Show the ring when starting the display

# Called every frame to update the ring's visibility and timer
func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		show()  # Redraw the ring every frame
	else:
		hide()  # Hide the ring after the duration ends

# Draws the ring with the specified radius_px, color, fill, and opacity
func _draw() -> void:
	if time_left > 0:
		if filled:
			# Draw a filled circle
			draw_circle(Vector2.ZERO, radius_px, ring_color)
		else:
			# Draw a ring outline (adjust thickness as needed)
			draw_circle(Vector2.ZERO, radius_px, ring_color, 2)

# Example function to trigger the ring display (you can connect this to a signal or call it directly)
func start_display() -> void:
	_show_ring()
