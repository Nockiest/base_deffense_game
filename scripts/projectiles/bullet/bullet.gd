extends Projectile
class_name Bullet

@export var damage_deal_component: DamageDealComponent

# Set the direction for the bullet and immediately update its velocity

func _on_area_entered(area: Area2D) -> void:
	print(area)
	print_debug('ef1',area, effects)
	
	#damage_deal_component.deal_damage(area, ['enemies', "turrets"])
	for effect in valid_effects:
		print_debug('ef',area, effect)
		effect.apply_to_entity(area)
	max_pierced_entities -= 1
	if self_destruction_component == null:
		printerr(self_destruction_component, ' is null')
		return
	if max_pierced_entities <= 0:
		self_destruction_component.kill_owner()
