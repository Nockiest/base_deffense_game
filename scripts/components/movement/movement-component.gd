class_name MovementComponent
extends Component

@export var base_speed_per_frame: float = 20.0
var speed_modifier: float = 1.0  # Speed modifier, starts at 100%
var direction: Vector2 = Vector2(1, 0)  # Default direction is right

# Variable to track the total distance traveled
var distance_traveled: float = 0.0

func _process(delta: float) -> void:
	if owner:
		# Calculate the movement vector for this frame
		var movement = direction.normalized() * clamp(base_speed_per_frame * speed_modifier * delta, 0, 1000)
		
		# Update the distance traveled by the magnitude of the movement vector
		distance_traveled += movement.length()

		# Move the owner node accordingly
		owner.position += movement
	else:
		push_error("Movement component doesn't have an owner: ", self)

# Handle child nodes entering the tree for effect handling, if relevant
func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("Child entered:", node)

# Update speed modifiers based on child nodes of EffectHoldComponent
func update_modifier(modifier: String, new_value: float) -> void:
	# Set the new value for the modifier, ensuring it's not negative
	set(modifier, max(new_value, 0))
