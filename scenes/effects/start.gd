class_name BaseEffectStateStart
extends State

func enter(_msg := {}):
	cause_start_effect()
	if owner.effect_type == EffectTypes.EFFECT_TYPE.ONE_SHOT:
		owner.get_parent().remove_effect(owner)
		return
	state_machine.transition_to('Active') 
	
func cause_start_effect(start_fce: Callable = owner.start_effect ) -> void:
	# If a callable is provided, call it; otherwise, use the default `start_effect`
	if start_fce != null and start_fce.is_valid():
		start_fce.call()
	elif owner.has_method('start_effect'):
		owner.start_effect()
	else: 
		printerr('owner doesnt have a start effect ', owner)
