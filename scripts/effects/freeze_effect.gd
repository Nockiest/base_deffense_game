class_name  FreezeEffect
extends BaseEffect


func _ready() -> void:
	pass  # Replace with function body.

func _process(delta: float) -> void:
	pass

func start_effect() -> void:
	print("Freeze effect started")
	if owner:
 
		
		# Apply a -100% speed modifier to stop the movement
		owner.add_speed_modifier("freeze", -1.0)  # -100% modifier

func exit_effect() -> void:
	print("Freeze effect ended")
	if owner:
		# Remove the -100% speed modifier and restore original speed
		owner.remove_speed_modifier("freeze")
