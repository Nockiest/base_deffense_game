class_name MovementComponent
extends Component

## TO DO promyslet jak zajistit aby se speed modifier p5i aktualizaci vždy propočítal od základu jedna
@export var base_speed_px_sec: float = 20.0
var speed_modifier: float = 1.0  # Start with base speed, which is 100%
var direction: Vector2 = Vector2(1, 0)

func _process(delta: float) -> void:
	if owner:
		# Calculate the movement vector for this frame
		var movement = direction.normalized() * clamp(base_speed_px_sec * speed_modifier * delta,0, 1000)
		# Move the owner node accordingly
		owner.position += movement
	else:
		printerr('Movement component doesn\'t have an owner: ', self)

# Update speed modifiers based on child nodes of EffectHoldComponent



func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("child entered")
	
func update_modifier(modifier=speed_modifier ,effect_variable_name:String ='speed_decimal_change' ) -> void:
	if not effect_hold_component:
		printerr("EffectHoldComponent is not set on MovementComponent")
		return
	var unique_modifiers =  Utils.parse_effect_modifiers_from_children(effect_hold_component,effect_variable_name )
	# Calculate the total modifier percentage	
	speed_modifier = Utils.calculate_modifier_from_dict(unique_modifiers) 
