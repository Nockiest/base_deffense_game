class_name  FreezeEffect
extends BaseEffect

var owner_original_speed:float


func get_type_name():
	return 'FreezeEffect'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_effect():
	owner_original_speed = owner.speed_px_sec
	owner.speed_px_sec  = 0.0
	
func exit_effect():
	owner.speed_px_sec  = owner_original_speed
