class_name MovementEffect
extends BaseEffect

@export var speed_modifier:float = 1
 
func start_effect():
	if  not owner is MovementComponent:
		push_error("wrong owner ", owner, " ", self)
	#owner.update_speed()

#func exit_effect():
	#owner.update_speed()
