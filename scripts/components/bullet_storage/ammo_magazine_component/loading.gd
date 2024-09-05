class_name MagazineLoading
extends State

func _ready() -> void:
	state_machine = get_parent()

func enter(_msg := {}) -> void:
	print('entered loading', owner.current_ammo)
	await get_tree().create_timer(owner.load_time_sec).timeout
	owner.current_ammo  =  owner.capacity
	state_machine.transition_to('Loaded')

func fire_bullet(_initial_rotation:float):
	print('i am currently reloading:', owner.current_ammo)
	return null
