class_name PlacablePreview
extends Area2D
 
var can_place:bool:
	set(value):
		can_place = value
		can_place_changed.emit(value)

signal can_place_changed(placable:bool)

func check_can_place():
	can_place = check_no_terrain_collision() and check_not_colliding()
	
func check_no_terrain_collision()->bool:
	return true

func check_not_colliding()->bool:
	var colliding_area =  get_overlapping_areas()
	var colliding_bodies = get_overlapping_bodies()

	print(colliding_area, ' colliding area', colliding_bodies)
	return len(colliding_area) ==  0 and  len(colliding_bodies) == 0

func _process(_delta: float) -> void:
	check_can_place()
 
