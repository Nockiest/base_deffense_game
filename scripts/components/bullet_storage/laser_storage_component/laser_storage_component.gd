class_name LaserStorageComponent
extends ProjectileStorage

@export var shoot_range_px := 1000

@export var laser_instance: Laser = null  # Holds the reference to the single laser instance

func fire_bullet(_initial_rotation: float) -> void:
	 

	laser_instance.set_direction(Utils.direction_from_rotation(0))
	laser_instance.toggle_active()
 
