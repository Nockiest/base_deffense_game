class_name MovementComponent
extends Component

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
	speed_modifier = 1
	if not effect_hold_component:
		printerr("EffectHoldComponent is not set on MovementComponent")
		return
	print('updating speed', effect_hold_component.get_children())
	
	# Retrieve all unique modifiers from EffectHoldComponent's children
	# Dictionary to hold unique modifiers based on child nodes of EffectHoldComponent
	var unique_modifiers: Dictionary = {}

	for child in effect_hold_component.get_children():
		if not child.effect_name:
			printerr(child, ' doesnt contain an effect name, ocurred in ', owner)
		var modifier_type = child.effect_name  # Assuming unique modifier types are identified by name
		var new_value = child.speed_decimal_change  # Assuming each child has this property
		
		# Check if the modifier type already exists in the dictionary
		if unique_modifiers.has(modifier_type):
			# Update the modifier if the new value is higher
			if unique_modifiers[modifier_type] < new_value:
				unique_modifiers[modifier_type] = new_value
		else:
			# Add the new modifier type with its value
			unique_modifiers[modifier_type] = new_value


	# Calculate the total modifier percentage

	# Apply only unique modifiers once
	for modifier in unique_modifiers.values():
		print_debug(modifier)
		speed_modifier += modifier

	


func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("child entered")
