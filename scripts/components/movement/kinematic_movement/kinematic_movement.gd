class_name KinematicComponent
extends MovementComponent

 
var velocity: Vector2 = Vector2.ZERO    # To hold the velocity

func _process(delta: float) -> void:
	pass
	#if owner:
		## Calculate the distance to move this frame
		#var movement = direction.normalized() * base_speed_px_sec * delta
 
		
func _physics_process(delta: float) -> void:
	if not owner:
		printerr('owner not set ',self) 
		return
	velocity = direction.normalized() * base_speed_px_sec * speed_modifier 
	prints(velocity, direction)
	
	if owner is CharacterBody2D   :
		owner.move_and_slide(velocity)
	elif owner is RigidBody2D:
		owner.linear_velocity = velocity
	else:
		printerr('owner is not rigidbody or kinematiic body ', owner)
