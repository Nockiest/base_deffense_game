class_name MovementComponent
extends Component

## TO DO promyslet jak zajistit aby se speed modifier p5i aktualizaci vždy propočítal od základu jedna
@export var base_speed_per_frame: float = 20.0
var speed_modifier: float = 1.0  # Start with base speed, which is 100%
var direction: Vector2 = Vector2(1, 0)

func _process(delta: float) -> void:
	if owner:
		# Calculate the movement vector for this frame
		var movement = direction.normalized() * clamp(base_speed_per_frame * speed_modifier * delta,0, 1000)
		# Move the owner node accordingly
		owner.position += movement
	else:
		printerr('Movement component doesn\'t have an owner: ', self)

# Update speed modifiers based on child nodes of EffectHoldComponent



func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("child entered", node)
	
func update_modifier(modifier: String, new_value: float) -> void:
 
	
	# Set the new value for the modifier, ensuring it's not negative
	set(modifier, max(new_value, 0))
