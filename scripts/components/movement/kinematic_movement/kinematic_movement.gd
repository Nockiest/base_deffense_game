class_name KinematicComponent
extends MovementComponent
## used for physicss bodies
 
var owner_direction:Vector2 


func _process(delta: float) -> void:
	pass
	#if owner:
		## Calculate the distance to move this frame
		#var movement = direction.normalized() * base_speed_per_frame * delta
 
		
func move_owner( delta:float, direction:Vector2 ) -> void:
	owner_direction = direction
	if not owner:
		printerr('owner not set ',self) 
		return
	owner.velocity = owner_direction.normalized() * base_speed_per_frame * speed_modifier * delta 
	#print(speed_modifier)
	owner.move_and_slide( )
	#if owner is CharacterBody2D   :
		#owner.move_and_slide( )
	#elif owner is RigidBody2D:
		#owner.linear_velocity = owner.velocity
	#else:
		#printerr('owner is not rigidbody or kinematiic body ', owner)
