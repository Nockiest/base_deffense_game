# MouseAimingComponent.gd
class_name MouseAimingComponent
extends AimingComponent

# Override to update the target position to the mouse position
func update_target_position() -> void:
	target_position = get_global_mouse_position()
