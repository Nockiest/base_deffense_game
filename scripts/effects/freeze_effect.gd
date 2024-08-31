class_name  FreezeEffect
extends BaseEffect

var owner_original_speed:float
 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_effect():
	print("freeze started")
	owner_original_speed = owner.speed_px_sec
	owner.speed_px_sec  = 0.0
	
func exit_effect():
	print("freeze ends")
	owner.speed_px_sec  = owner_original_speed
