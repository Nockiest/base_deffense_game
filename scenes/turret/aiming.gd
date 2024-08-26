extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
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

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:  # Check if the event is a mouse button event
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if owner.bullet_scene:
				fire_bullet()
			print("Left mouse button clicked")
		else:
			print("Other mouse button event")

func fire_bullet():
	if owner.ammo_magazine_component.current_ammo <= 0:
		owner.ammo_magazine_component.load_ammo()
		print('Told mag to load one ammo')
		return
	var bullet_instance =  owner.ammo_magazine_component.expend_ammo()
	if    bullet_instance  == null :
		print('magazine didnt gave me ammo', bullet_instance)
		return
	# Instantiate the bullet scene
	print(bullet_instance,  bullet_instance  == null)
	bullet_instance = bullet_instance.instantiate()
	bullet_instance.global_position = owner.global_position
	
	# Calculate the bullet's direction based on the turret's rotation
	var bullet_direction = Vector2(cos(owner.rotation - deg_to_rad(90)), sin(owner.rotation - deg_to_rad(90)))
	print(bullet_direction)
	
	# Set the direction for the bullet's movement
	bullet_instance.set_direction(bullet_direction)
	
	# Add the bullet to the scene tree
	get_tree().current_scene.add_child(bullet_instance)
