# AreaEffectComponent.gd
extends AreaOfEffectComponent
class_name  Node2DAreaOfEffectComponent 
# Function to apply an effect to nearby entities
func apply_area_effect(effect_function: Callable, target_groups: Array[String], radius_px: float = effect_radius_px, center_position: Vector2 = self.global_position) -> void:
	prints('called', effect_function, target_groups, radius_px)
	if len(target_groups) == 0:
		push_error('Target groups set badly', owner)
		return

	for group_name in target_groups:
		# Check if the scene tree has the target group
		if not get_tree():
			push_error("tree not set")
			return
		if not get_tree().has_group(group_name):
			push_error('Group does not exist in the scene tree:', group_name)
			continue
		var entities = get_tree().get_nodes_in_group(group_name)
		if len(entities) == 0:
			push_error('No entities in group', group_name, owner)
			continue
		
		for entity in entities:
			if entity is Node2D and is_instance_valid(entity):
				var distance_to_entity = center_position.distance_to(entity.global_position)
				# Check if the entity is within the effect radius
				if distance_to_entity <= radius_px:
					# Apply the effect using the provided callback function
					effect_function.callv([entity])
				#else:
					#print("Entity out of effect range:", entity)
