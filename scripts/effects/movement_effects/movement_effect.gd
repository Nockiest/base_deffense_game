class_name MovementEffect
extends BaseEffect

@export var speed_decimal_change:float = 1
 
 
func start_effect():
	if  not owner is MovementComponent:
		printerr("wrong owner ", owner, " ", self)
	#owner.update_speed()

#func exit_effect():
	#owner.update_speed()
