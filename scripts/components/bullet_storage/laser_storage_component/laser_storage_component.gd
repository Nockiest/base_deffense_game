class_name LaserStorageComponent
extends ProjectileStorage

@export var shoot_range_px := 1000

var laser_instance: Laser = null  # Holds the reference to the single laser instance

func fire_bullet(initial_rotation: float) -> void:
	if not laser_instance:
		# Instantiate the laser only if it doesn't already exist
		laser_instance = await stored_bullet.instantiate() as Laser
		laser_instance.range_px = shoot_range_px
		add_child(laser_instance)

	# Set direction for the laser
	laser_instance.set_direction(Utils.direction_from_rotation(0))

	## Activate the laser
	#laser_instance.activate()
#
	## Optionally deactivate it after some time if needed
	## For example, to deactivate after 2 seconds:
	#await (get_tree().create_timer(2.0), "timeout")
	#laser_instance.deactivate()
