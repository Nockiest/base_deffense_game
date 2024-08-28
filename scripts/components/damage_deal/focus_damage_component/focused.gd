class_name FocusTimeState
extends State


# This function is called every frame
func _process(_delta: float) -> void:
	# Increase focus time by the time elapsed since the last frame
	owner.focus_time += _delta
	
func handle_entity_change(entity:Node):
	if   entity == null:
		state_machine.transition_to('Idle') 
	else:
		owner.focus_time = 0
 
	 

 
