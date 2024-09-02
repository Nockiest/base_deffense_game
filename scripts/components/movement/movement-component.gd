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
func update_modifier() -> void:
	if not effect_hold_component:
		printerr("EffectHoldComponent is not set on MovementComponent")
		return
	var unique_modifiers =  parse_effect_modifiers_from_children(effect_hold_component,'speed_decimal_change')
	# Calculate the total modifier percentage	
	speed_modifier = Utils.calculate_modifier_from_dict(unique_modifiers) 
	# Apply only unique modifiers once
func parse_effect_modifiers_from_children(node: EffectHoldComponent, value_property: String) -> Dictionary:
	var unique_modifiers: Dictionary = {}

	for child in node.get_children():
		if not value_property in child:
			printerr(child, " doesn't contain the property ", value_property, ", occurred in ", owner)
			continue
		
		if not child.effect_name:
			printerr(child, " doesn't contain an effect name, occurred in ", owner)
			continue
		
		var modifier_type = child.effect_name  # Assuming unique modifier types are identified by name
		var new_value = child.get(value_property)  # Use get() to retrieve the value dynamically
		
		# Check if the modifier type already exists in the dictionary
		if unique_modifiers.has(modifier_type):
			# Update the modifier if the new value is higher
			if unique_modifiers[modifier_type] < new_value:
				unique_modifiers[modifier_type] = new_value
		else:
			# Add the new modifier type with its value
			unique_modifiers[modifier_type] = new_value
			
	return unique_modifiers

	


func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("child entered")
	
