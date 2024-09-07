class_name SelfDestructionComponent
extends Component
 
func kill_owner() -> void:
	if owner and is_instance_valid(owner):
		print_debug("killing owner ", owner)
		owner.queue_free()
	else:
		push_error("Cannot kill owner: owner is null or already freed.")

 

 
