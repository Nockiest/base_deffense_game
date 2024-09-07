class_name AmmoMagazine
extends ProjectileStorage


# Load a single ammo after the load time has passed
func load_ammo() -> void:
	if $StateMachine.state == $StateMachine/Loaded:
		$StateMachine.transition_to('Loading')
 

func fire_bullet(initial_rotation:float=  owner.rotation) -> Variant:
	return $StateMachine.state.fire_bullet(initial_rotation)

	# i should try to get rid of this if check
 
