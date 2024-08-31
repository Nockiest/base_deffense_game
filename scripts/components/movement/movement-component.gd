class_name MovementComponent
extends Component

 

@export var base_speed_px_sec: float = 20.0#:
 
@onready var speed_px_sec = base_speed_px_sec
var direction: Vector2 = Vector2(1, 0)  # Default direction to the right


func _process(delta: float) -> void:
	if owner:
		# Calculate the distance to move this frame
		var movement = direction.normalized() * speed_px_sec * delta
		
		# Move the parent by adjusting its position
		owner.position += movement
	else:
		printerr('movement comp doesnt have an owner ', self)

## TO DO ADD LOGIC TO ONLY CHANGE THE MOVEMENT BY A CERTAIN AMMOUNT OF BASE MOVEMENT PERCENT, MAYE USE AMODIFIER
func stop_movement():
	speed_px_sec = 0
	
func resume_movement():
	speed_px_sec = base_speed_px_sec
