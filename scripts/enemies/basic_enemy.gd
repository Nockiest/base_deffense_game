class_name Enemy
extends Area2D

 

@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var self_destruction_component: SelfDestructionComponent
@export var aiming_component: AimingComponent  # Reference to the AimingComponent
@export var melee_attack_component: MeleeAttackComponent  # Reference to the AimingComponent
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if aiming_component and movement_component:
		# Get the target position from the AimingComponent
		var target_position = aiming_component.target_position
		# Calculate the direction vector from the Enemy to the target position
		var direction = (target_position - global_position).normalized()

		# Set the direction of the MovementComponent
		movement_component.direction = direction

 


func _on_health_component_hp_ran_out() -> void:
	if self_destruction_component:
		self_destruction_component.kill_owner() 


 

 
