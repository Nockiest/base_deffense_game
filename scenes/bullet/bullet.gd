# Bullet.gd
extends RigidBody2D

class_name Bullet

# Bullet speed
@export var speed: float = 500

# Direction in which the bullet will move
var direction: Vector2 = Vector2()

 

# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	print(direction)
	linear_velocity = direction * speed
