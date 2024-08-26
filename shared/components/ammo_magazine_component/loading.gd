class_name MagazineLoading
extends State

func _ready() -> void:
	state_machine = get_parent()

func enter(_msg := {}) -> void:
	if owner.current_ammo < owner.capacity:
		await get_tree().create_timer(owner.load_time_sec).timeout
		owner.current_ammo  =  owner.capacity
		state_machine.transition_to('Loaded')

#func expend_ammo():
	#print("cant expend ammo when loading")
	#return null
