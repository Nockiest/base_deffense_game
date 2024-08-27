class_name MagazineLoaded
extends State

# Ensure you have a Timer node in the scene or instantiate it in code
@export var bullet_prepared:= true
func _ready() -> void:
	state_machine = get_parent()
	
func _prepare_next_shot():
	bullet_prepared = false
	await get_tree().create_timer(owner.shoot_interval_sec).timeout
	bullet_prepared = true
	
func fire_bullet(initial_rotation:float):
	if owner.current_ammo > 0 and bullet_prepared:
		print('Expended ammo, current ammo:', owner.current_ammo)
		_prepare_next_shot()
		create_bullet(initial_rotation )
		return owner.stored_bullet
	elif owner.current_ammo <= 0:
		state_machine.transition_to('Loading')
		print('No ammo left')
		return null
	else:
		print('cant shoot yet')
		return null
 
func create_bullet(initial_rotation:float):
	owner.current_ammo -= 1
	# Instantiate the bullet scene
	print(owner.stored_bullet,  owner.stored_bullet  == null)
	var new_bullet_instance = owner.stored_bullet.instantiate()
	new_bullet_instance.global_position = owner.global_position
	
	# Calculate the bullet's direction based on the turret's rotation
	var bullet_direction = Vector2(cos(initial_rotation - deg_to_rad(90)), sin(initial_rotation - deg_to_rad(90)))
	print(bullet_direction)
	
	# Set the direction for the bullet's movement
	new_bullet_instance.set_direction(bullet_direction)
	
	# Add the bullet to the scene tree
	get_tree().current_scene.add_child(new_bullet_instance)
