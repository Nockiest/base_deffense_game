class_name CursorHoldedSprite
extends Sprite2D


# Called when the node enters the scene tree for the first time.

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	# Ignore all input events
	if event is InputEventMouseButton:
		event.ignore()
