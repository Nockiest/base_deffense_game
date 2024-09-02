class_name MovementEffect
extends BaseEffect

@export var speed_modifier:float = 1
 #
#func _ready():
	#modulated_modifier  = "speed_modifier"  
 
func start_effect():
	if  not owner is MovementComponent:
		printerr("wrong owner ", owner, " ", self)
	#owner.update_speed()

#func exit_effect():
	#owner.update_speed()
