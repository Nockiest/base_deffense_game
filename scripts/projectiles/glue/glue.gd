extends Projectile


func _on_area_entered(area: Area2D) -> void:
	printerr('doesnt have on area entered')
	print(area)
	print_debug('ef1',area, effects)
	
	for effect in valid_effects:
		print_debug('ef',area, effect)
		effect.apply_to_entity(area)
	if self_destruction_component == null:
		printerr(self_destruction_component, ' is null')
		return
	self_destruction_component.kill_owner()
