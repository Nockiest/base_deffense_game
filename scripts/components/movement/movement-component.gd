class_name MovementComponent
extends Component

@export var base_speed_px_sec: float = 20.0
@onready var speed_px_sec: float = base_speed_px_sec:
	set(value):
			# Clamp the speed between 0 and 1000 px/sec
		if value < 0:
			value = 0
			printerr('Speed clamped to 0 px/sec')
		elif value > 1000:
			value = 1000
			printerr('Speed clamped to 1000 px/sec')
		speed_px_sec = value
# Dictionary to hold speed modifiers as percentages (e.g., 0.5 for 50%)
# Default direction is to the right
var direction: Vector2 = Vector2(1, 0)
 
func _ready() -> void:
	if !effect_hold_component:
		printerr("effect hold comp not set ", self, " ", owner)
	#effect_hold_component.connect("child_entered",  update_speed  )
	#effect_hold_component.connect("child_exited",update_speed  )
	update_modifier()  # Initialize the speed based on current modifiers

func _process(delta: float) -> void:
	if owner:
		# Calculate the movement vector for this frame
		var movement = direction.normalized() * speed_px_sec * delta
		# Move the owner node accordingly
		owner.position += movement
	else:
		printerr('Movement component doesn\'t have an owner: ', self)

# Update speed modifiers based on child nodes of EffectHoldComponent
func update_modifier() -> void:
	if not effect_hold_component:
		printerr("EffectHoldComponent is not set on MovementComponent")
		return
	print('updating speed', effect_hold_component.get_children())
	
	# Retrieve all unique modifiers from EffectHoldComponent's children
	# Dictionary to hold unique modifiers based on child nodes of EffectHoldComponent
	var unique_modifiers: Dictionary = {}

	for child in effect_hold_component.get_children():
		var modifier_type = child.name  # Assuming unique modifier types are identified by name
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
	var total_modifier: float = 1.0  # Start with base speed, which is 100%

	# Apply only unique modifiers once
	for modifier in unique_modifiers.values():
		total_modifier += modifier

	# Calculate the new speed
	speed_px_sec = base_speed_px_sec * total_modifier


func _on_effect_hold_component_child_entered_tree(node: Node) -> void:
	print_debug("child entered")
