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
	return false

func check_not_colliding()->bool:
	var colliding_area = get_overlapping_areas()
	print(colliding_area, ' colliding area')
	return len(colliding_area) ==  0

func _process(_delta: float) -> void:
	check_can_place()
