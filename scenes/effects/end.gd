class_name BaseEffectStateEnd
extends State

func enter(msg:Dictionary = {}):
	cause_exit_effect()
	
func cause_exit_effect(callback: Callable = owner.exit_effect  ) -> void:
	print('calling exit eff ', callback)
	# Check if a callable function is provided
	if callback != null and callback.is_valid():
		# Call the provided function
		callback.call()
	owner.get_parent().remove_effect(owner)
