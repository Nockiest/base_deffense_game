# AreaEffectComponent.gd
class_name AreaOfEffectComponent
extends Component 

@export var effect_radius_px: float = 400.0  # Radius within which to apply the effect

# Function to apply an effect to nearby entities
func apply_area_effect(effect_function: Callable, target_groups: Array[String], radius_px: float = effect_radius_px, center_position: Vector2 = self.global_position) -> void:
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
		# Check if the collider is a Node2D and belongs to any of the target groups
		if body is Node2D:
			for group in target_groups:
				if body.is_in_group(group):
					print("Body within effect range:", body.name, " at position:", body.global_position)
					# Call the effect function on the body
					effect_function.callv([body])
					break  # Stop checking other groups once a match is found
