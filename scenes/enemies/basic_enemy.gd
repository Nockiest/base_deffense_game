extends Area2D

class_name Enemy

@export var health_component: HealthComponent
@export var movement_component: MomvementComponent
@export var death_component: DeathComponent
@export var aiming_component: AimingComponent  # Reference to the AimingComponent
@export var melee_attack_component: MeleeAttackComponent  # Reference to the AimingComponent
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if aiming_component and movement_component:
		# Get the target position from the AimingComponent
		var target_position = aiming_component.target_position

		# Calculate the direction vector from the Enemy to the target position
		var direction = (target_position - global_position).normalized()

		# Set the direction of the MovementComponent
		movement_component.direction = direction

# Called when the health component's health runs out
func _on_health_component_health_ran_out() -> void:
	if death_component:
		death_component.kill_owner()
