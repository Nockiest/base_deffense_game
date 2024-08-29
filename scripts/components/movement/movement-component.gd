class_name MovementComponent
extends Component

func get_type_name():
	return "MovementComponent"

@export var speed_px_sec: float = 20.0
var direction: Vector2 = Vector2(1, 0)  # Default direction to the right

func _process(delta: float) -> void:
	if owner:
		# Calculate the distance to move this frame
		var movement = direction.normalized() * speed_px_sec * delta
		
		# Move the parent by adjusting its position
		owner.position += movement
