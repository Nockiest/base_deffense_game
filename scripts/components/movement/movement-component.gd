class_name MovementComponent
extends Component

@export var base_speed_px_sec: float = 20.0
@onready var speed_px_sec: float = base_speed_px_sec

# Dictionary to hold speed modifiers as percentages (e.g., 0.5 for 50%)
var speed_modifiers: Dictionary = {}

var direction: Vector2 = Vector2(1, 0)  # Default direction to the right

func _ready() -> void:
	update_speed()

func _process(delta: float) -> void:
	if owner:
		# Calculate the distance to move this frame
		var movement = direction.normalized() * speed_px_sec * delta
		
		# Move the parent by adjusting its position
		owner.position += movement
	else:
		printerr('Movement component doesn\'t have an owner: ', self)

func add_speed_modifier(name: String, modifier: float) -> void:
	speed_modifiers[name] = modifier
	update_speed()

func remove_speed_modifier(name: String) -> void:
	if speed_modifiers.has(name):
		speed_modifiers.erase(name)
		update_speed()

func update_speed() -> void:
	# Calculate the total modifier percentage
	var total_modifier: float = 1.0  # Start with base speed, which is 100%
	for modifier in speed_modifiers.values():
		total_modifier += modifier
	
	# Update speed based on modifiers
	var new_speed: float = base_speed_px_sec * total_modifier

	# Clamp the speed between 0 and 1000 px/sec
	if new_speed < 0:
		new_speed = 0
		printerr('Speed clamped to 0 px/sec')
	elif new_speed > 1000:
		new_speed = 1000
		printerr('Speed clamped to 1000 px/sec')
	
	speed_px_sec = new_speed
