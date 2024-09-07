extends Projectile


func _on_area_entered(area: Area2D) -> void:
	
	for effect in valid_effects:
		print_debug('ef',area, effect)
		effect.apply_to_entity(area)
	if self_destruction_component == null:
		push_error(self_destruction_component, ' is null')
		return
	self_destruction_component.kill_owner()
