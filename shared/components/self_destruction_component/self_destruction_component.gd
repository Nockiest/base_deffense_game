class_name SelfDestructionComponent
extends Node2D
 
func kill_owner():
	print_debug("killing owner ", owner)
	owner.queue_free()

 

 
