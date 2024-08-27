class_name FixedPointAimingComponent
extends AimingComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_target_position()

# Update the target position based on the fixed point
func update_target_position() -> void:
	# Directly set the target position to the fixed point
	target_position = target_position
	# Make the owner look at the fixed point
	if get_parent() is Node2D:
		get_parent().look_at(target_position)

 
