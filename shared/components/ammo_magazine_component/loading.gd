class_name MagazineLoading
extends State

func _ready() -> void:
	state_machine = get_parent()

func enter(_msg := {}) -> void:
	print('entered loading')
	#if owner.current_ammo > owner.capacity:
		#state_machine.transition_to('Loaded')
	if owner.current_ammo > 0:
		await get_tree().create_timer(owner.shoot_interval_sec).timeout
	elif owner.current_ammo <= 0:
		await get_tree().create_timer(owner.load_time_sec).timeout
	else:
		printerr("owner ammo count cant be handled", owner.current_ammo)
	owner.current_ammo  =  owner.capacity
	state_machine.transition_to('Loaded')

func expend_ammo():
	print('i am currently reloading:', owner.current_ammo)
	return null
