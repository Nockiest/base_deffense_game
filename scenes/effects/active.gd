class_name BaseEffectStateActive
extends State

func enter(msg:Dictionary ={}):
	owner.effect_timer.start()
	owner.effect_timer.wait_time = owner.duration_sec
	if owner.effect_timer == null:
		printerr("effect copy doesmt have an effect timer")
		return 
	if  owner.effect_timer.wait_time!= 1:
		printerr("dont set effect timer duration directly in wait time it will be overriden")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if owner.effect_type == EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND:
		owner.interval_timer += delta
		if owner.interval_timer >= owner.effect_interval:
			owner.interval_timer = 0.0
			cause_per_second_effect()

func cause_per_second_effect(per_sec_fce: Callable = owner.per_second_effect ) -> void:
	if per_sec_fce != null and per_sec_fce.is_valid():
		per_sec_fce.call()
	elif owner.has_method('per_second_effect'):
		owner.per_second_effect()
	else:
		printerr('owner doesnt have per second effect: ', owner)

func _on_timer_timeout() -> void:
	print('timer ended')
	state_machine.transition_to('End')
	
