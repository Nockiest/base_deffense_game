# AreaEffectComponent.gd
class_name AreaOfEffectComponent
extends Component 

@export var effect_radius_px: float = 400.0  # Radius within which to apply the effect

# Function to apply an effect to nearby entities
func apply_area_effect(effect_function: Callable, target_groups: Array[String], radius_px: float = effect_radius_px, center_position: Vector2 = self.global_position) -> void:
	prints('called', effect_function, target_groups, radius_px)
	if len(target_groups) == 0:
		printerr('Target groups set badly', owner)
		return

	for group_name in target_groups:
		# Check if the scene tree has the target group
		if not get_tree():
			printerr("tree not set")
			return
		if not get_tree().has_group(group_name):
			printerr('Group does not exist in the scene tree:', group_name)
			continue
		var entities = get_tree().get_nodes_in_group(group_name)
		if len(entities) == 0:
			printerr('No entities in group', group_name, owner)
			continue
		
		for entity in entities:
			if entity is Node2D and is_instance_valid(entity):
				var distance_to_entity = center_position.distance_to(entity.global_position)
				# Check if the entity is within the effect radius
				if distance_to_entity <= radius_px:
					# Apply the effect using the provided callback function
					effect_function.callv([entity])
				else:
					print("Entity out of effect range:", entity)
	
	# Check for collision shapes within the radius
	_check_collision_shapes_within_radius(center_position, radius_px, effect_function)

# Function to check collision shapes within the effect radius
func _check_collision_shapes_within_radius(center_position: Vector2, radius_px: float, effect_function: Callable) -> void:
	var space_state = get_world_2d().direct_space_state

	# Define the query shape as a circle with the effect radius
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = radius_px

	# Setup the query parameters
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = circle_shape
	query.transform = Transform2D(0, center_position)  # Position the circle at the center
	query.collide_with_areas = true
	query.collide_with_bodies = true

	# Perform the query
	var results = space_state.intersect_shape(query, 32)  # Maximum of 32 results
	
	for result in results:
		var body = result.collider
		if body is Node2D:
			print("Body within effect range:", body.name, " at position:", body.global_position)
			# Optionally apply the effect to the body
			effect_function.callv([body])
