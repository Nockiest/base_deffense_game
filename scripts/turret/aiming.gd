extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
var fire_btn_pressed:= false

func _process(delta: float) -> void:
	if owner.aiming_component:
		# Get the position of the turret
		var turret_position = owner.global_position
		# Get the position of the mouse from the AimingComponent
		var mouse_position = owner.aiming_component.target_position
		# Calculate the direction vector from the turret to the mouse
		var direction = (mouse_position - turret_position).normalized()
		# Calculate the angle from the direction vector and set the rotation of the turret
		owner.rotation = direction.angle() + deg_to_rad(90)  # Fixed the use of direction
	if fire_btn_pressed:
		owner.ammo_magazine_component.fire_bullet(owner.rotation)
func _input(event: InputEvent) -> void:
	 
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			fire_btn_pressed = true
		else:
			fire_btn_pressed=false
	#if event is InputEventMouseButton:  # Check if the event is a mouse button event
		#print( event.button_index == MOUSE_BUTTON_LEFT, event.pressed)
		 #is_action_pressed
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			##if owner.bullet_scene:
			#fire_bullet()
	
