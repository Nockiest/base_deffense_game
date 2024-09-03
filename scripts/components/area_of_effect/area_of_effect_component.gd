class_name AreaOfEffectComponent
extends Component

@export var effect_radius_px: float = 400.0  # Radius within which to apply the effect
@export var radius_visualizer: RadiusVisualizer

 
# Function to apply an effect to nearby entities using Geometry calculations
func apply_area_effect(effect_function: Callable, target_groups: Array[String], radius_px: float = effect_radius_px, center_position: Vector2 = self.global_position) -> void:
	var affected_bodies = []
	radius_visualizer.start_display(effect_radius_px,5, owner.scale)
	# Loop through each target group
	for group in target_groups:
		# Get all nodes in the specified group
		var nodes_in_group = get_tree().get_nodes_in_group(group)

		# Check each node in the group
		for body in nodes_in_group:
			# Ensure the node is a Node2D
			if not body is Node2D:
				printerr(body, ' isnt node2d, found in: ', self)
				# Retrieve collision shapes and relevant points
			var collision_points = _get_collision_points(body)
		
			# Check if any collision points are inside the effect circle
			for point in collision_points:
				prints(Geometry2D.is_point_in_circle(point, center_position, radius_px),center_position, point, center_position.distance_to(point))
				if Geometry2D.is_point_in_circle(point, center_position, radius_px):
					affected_bodies.append(body)
					print("Body within effect range:", body.name, " at position:", body.global_position)
					break  # No need to check other points if one is inside

	# Apply the effect to all affected bodies
	for body in affected_bodies:
		effect_function.call(body)

# Helper function to get points from a body's collision shape
func _get_collision_points(body: Node2D) -> Array:
	var points = []

	# Loop through all collision shapes in the body
	for child in body.get_children():
		if child is CollisionShape2D:
			var shape = child.shape
			# Check the type of shape and extract relevant points
			if shape is CircleShape2D:
					points.append(child.to_global(Vector2.ZERO))  # Center of the circle
			elif shape is	RectangleShape2D:
				var extents = shape.extents
				points.append(child.to_global(Vector2(-extents.x, -extents.y)))
				points.append(child.to_global(Vector2(extents.x, -extents.y)))
				points.append(child.to_global(Vector2(extents.x, extents.y)))
				points.append(child.to_global(Vector2(-extents.x, extents.y)))
			elif shape is CapsuleShape2D or   shape is ConvexPolygonShape2D or   shape is ConcavePolygonShape2D:
				# Additional logic for other shapes can be added here
				# Since we're printing, let's ensure we handle unsupported shapes gracefully
				printerr('Haven’t written a function to find points of this collision shape:', child,shape,shape is RectangleShape2D, self)
			else:  # Default case for any other shapes not explicitly handled
				printerr('xHaven’t written a function to find points of this collision shape:', child, shape, shape is RectangleShape2D, self)

	return points
