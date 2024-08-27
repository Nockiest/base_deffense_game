class_name FocusTimeState
extends Node


# This function is called every frame
func _process(_delta: float) -> void:
	# Increase focus time by the time elapsed since the last frame
	owner.focus_time += _delta
	



 
