class_name AreaDamageComponent
extends DamageDealComponent

@export var damage_radius_px: float = 100.0  # Radius within which to deal damage
#@export var collision_mask: int = 1  # The collision mask to identify the objects that can be damaged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Additional setup if needed
	pass

# Called when the node needs to deal damage
func deal_damage(reciever, damagable_object_groups: Array,center_position: Vector2 = self.global_position):
	deal_area_damage(  damagable_object_groups,center_position)

# Function to deal damage to nearby entities
func deal_area_damage( damagable_object_groups: Array,center_position:Vector2):
	if len(damagable_object_groups) == 0 :
		printerr('damagable obj groups set badly', owner)
	for group_name in damagable_object_groups: 
		if len(get_tree().get_nodes_in_group(group_name)) == 0 :
			printerr('no entities in group ', group_name, ' ', owner)
		for entity in get_tree().get_nodes_in_group(group_name):
			if entity is Node2D:
				var distance_to_entity = center_position.distance_to(entity.global_position)
				
				# Check if the entity is within the damage radius
				if distance_to_entity <= damage_radius_px:
					# Apply damage if the entity has a health component
					print(entity)
					if entity.health_component.has_method("take_hit"):
						entity.health_component.take_hit(base_damage)
					else:
						printerr("Entity doesn't have take_hit method. Skipping:", entity)
				else:
					print("Entity out of damage range:", entity)
