class_name Enemy
extends CharacterBody2D

@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var self_destruction_component: SelfDestructionComponent
@export var aiming_component: AimingComponent  # Reference to the AimingComponent
@export var melee_attack_component: MeleeAttackComponent  # Reference to the AimingComponent

@export_group('stats')
@export var gold_on_death := 10 
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

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
	GoldManager.gold += gold_on_death
func _physics_process(delta: float) -> void:
	var dir = to_local(navigation_agent_2d.get_next_path_position())
	#velocity = dir * speed_px_sec
	movement_component.move_owner(delta, dir)
	#move_and_slide()

func make_path():
	navigation_agent_2d.target_position = aiming_component.target_position


func _on_navigation_update_timeout() -> void:
	make_path()

func respond_to_click(click_power):
	health_component.take_hit(click_power)
	
