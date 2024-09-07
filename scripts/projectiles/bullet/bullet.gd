extends Projectile
class_name Bullet

@export var damage_deal_component: DamageDealComponent

# Set the direction for the bullet and immediately update its velocity

func _on_area_entered(area  ) -> void:
	print(area)
	print_debug('ef1',area, effects)
	attack_node(area)
	 

func _on_body_entered(body: Node2D) -> void:
	attack_node(body)
	
func attack_node(body):
	for effect in valid_effects:
		print_debug('ef',body, effect)
		effect.apply_to_entity(body)
	max_pierced_entities -= 1
	if self_destruction_component == null:
		printerr(self_destruction_component, ' is null')
		return
	if max_pierced_entities <= 0:
		self_destruction_component.kill_owner()
