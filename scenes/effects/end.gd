class_name BaseEffectStateEnd
extends State

func enter(_msg:Dictionary = {}):
	cause_exit_effect()
	
func cause_exit_effect(callback: Callable = owner.exit_effect  ) -> void:
	# Check if a callable function is provided
	if callback != null and callback.is_valid():
		# Call the provided function
		callback.call()
	owner.get_parent().remove_effect(owner,owner.modulated_modifier)
