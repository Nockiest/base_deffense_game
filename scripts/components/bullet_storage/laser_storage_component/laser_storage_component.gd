class_name LaserStorageComponent
extends ProjectileStorage

	

func fire_bullet(initial_rotation:float):
	var new_laser = await stored_bullet.instantiate()
	add_child(new_laser)
	if new_laser.raycast.enabled:
		new_laser.toggle_active()

	# Child-specific initialization logic here

 
