extends Projectile

class_name Bullet

@export var movement_component: MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectiles")
# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	# Update the movement component's direction
	if movement_component:
		movement_component.direction = new_direction.normalized()
