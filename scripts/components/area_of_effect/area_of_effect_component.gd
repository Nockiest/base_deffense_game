# AreaEffectComponent.gd
class_name AreaOfEffectComponent
extends Node

#@export var effect_radius_px: float = 100.0  # Radius within which to apply the effect

# Function to apply an effect to nearby entities
func apply_area_effect(effect_function: Callable, target_groups: Array[String], effect_radius_px: float, center_position: Vector2 = self.global_position) -> void:
	if len(target_groups) == 0:
		printerr('Target groups set badly', owner)
		return

	for group_name in target_groups:
		var entities = get_tree().get_nodes_in_group(group_name)
		#print('entities', entities)
		if len(entities) == 0:
			printerr('No entities in group', group_name, owner)
			continue
		
		for entity in entities:
			if entity is Node2D and  is_instance_valid(entity) :
				var distance_to_entity = center_position.distance_to(entity.global_position)
				#Utils.print_spaced([entity  ,distance_to_entity])
				# Check if the entity is within the effect radius
				if distance_to_entity <= effect_radius_px:
					# Apply the effect using the provided callback function
					effect_function.call(entity)
				else:
					print("Entity out of effect range:", entity)
