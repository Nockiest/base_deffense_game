extends State

# Called every frame. 'delta' is the elapsed time since the previous frame.

func enter(_msg := {}):
	owner.auto_shoot_component.enabled = true

func _process(_delta: float) -> void:
	if owner.aiming_component:
		# Get the position of the turret
		var turret_position = owner.global_position
		# Get the position of the mouse from the AimingComponent
		var mouse_position = owner.aiming_component.target_position
		# Calculate the direction vector from the turret to the mouse
		var direction = (mouse_position - turret_position).normalized()
		# Calculate the angle from the direction vector and set the rotation of the turret
		owner.rotation = direction.angle() + deg_to_rad(90)  # Fixed the use of direction
	

func _on_entity_aiming_component_target_changed(target: Node2D) -> void:
	print('target_changed', target, owner)
	if not target:
		state_machine.transition_to('Idle')
