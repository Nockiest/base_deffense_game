class_name MagazineLoaded
extends State


func load_ammo() -> void:
	if owner.current_ammo < owner.capacity:
		state_machine.transition_to('loading')
 
func expend_ammo():
	if owner.current_ammo <= 0:
		load_ammo()
		return null
	owner.current_ammo -= 1
	print('Expended ammo, current ammo:', owner.current_ammo)
	return owner.stored_bullet
