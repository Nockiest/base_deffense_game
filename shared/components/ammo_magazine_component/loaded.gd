class_name MagazineLoaded
extends State

# Ensure you have a Timer node in the scene or instantiate it in code
#@export var time_between_shots: float = 1.0  # Cooldown time in seconds
@export var bullet_prepared:= true
func _ready() -> void:
	state_machine = get_parent()
	
func _prepare_next_shot():
	bullet_prepared = false
	await get_tree().create_timer(owner.shoot_interval_sec).timeout
	bullet_prepared = true
func expend_ammo():
	if owner.current_ammo > 0 and bullet_prepared:
		owner.current_ammo -= 1
		print('Expended ammo, current ammo:', owner.current_ammo)
		_prepare_next_shot()
		

		
		return owner.stored_bullet
	elif owner.current_ammo <= 0:
		state_machine.transition_to('Loading')
		print('No ammo left')
		return null
	else:
		print('cant shoot yet')
		return null
 

func _on_cooldown_timeout() -> void:
	# This function is called when the cooldown timer times out
	print('Cooldown complete, ready to shoot again')
