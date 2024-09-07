class_name AreaDamageComponent
extends DamageDealComponent

@export var damage_radius_px: float = 100.0  # radius_px within which to deal damage
@export var area_of_effect_component: AreaOfEffectComponent

# Called when the node needs to deal damage
func deal_damage(_reciever,  center_position: Vector2 = self.global_position,damagable_object_groups: Array[String]=[] ):
	if len(damagable_object_groups)==0:
		push_error('dmg object groups are 0', damagable_object_groups, self, owner)
	
	if area_of_effect_component:
		# Pass the function to apply damage as a Callable to the AreaOfEffectComponent
		#var damage_callable = Callable(self, "_apply_damage")
		area_of_effect_component.apply_area_effect(_apply_damage, damagable_object_groups, damage_radius_px, center_position)
	else:
		push_error("AreaOfEffectComponent is not assigned to", owner)

# Private function to apply damage to a single entity
func _apply_damage(entity: Node2D) -> void:
	if entity.health_component and entity.health_component.has_method("take_hit"):
		entity.health_component.take_hit(base_damage)
	else:
		push_error("Entity doesn't have take_hit method. Skipping:", entity)
