class_name MeleeAttackComponent
extends Component

@export var attack_range_px: float = 50.0  # Range within which the attack can happen
@export var attack_delay_sec: float = 1.0  # Delay between detecting and attacking
@export var damage_amount: int = 10  # Amount of damage to apply

@export var damage_deal_component: DamageDealComponent
@export var aiming_component: AimingComponent

# Reference to the enemy node to attack
var enemy: Node2D

# Timer for the attack delay
var attack_timer: Timer = Timer.new()

func _ready() -> void:
	# Initialize the attack timer
	attack_timer.wait_time = attack_delay_sec
	attack_timer.one_shot = true
	add_child(attack_timer)
	
	# Ensure that an enemy is assigned
	if not enemy:
		print("No enemy assigned to MeleeAttackComponent!")

func _process(_delta: float) -> void:
	if enemy and is_instance_valid(enemy):
		# Calculate the distance to the enemy
		var distance_to_enemy = global_position.distance_to(enemy.global_position)
		
		# If the enemy is within range and the timer is stopped, attack the enemy
		if distance_to_enemy <= attack_range_px and attack_timer.is_stopped():
			attack_timer.start()  # Start the timer for the next attack
			damage_deal_component.deal_damage(enemy, ['enemies'])  # Deal damage to the enemy
	#else:
		#print("No enemy assigned or enemy not in range!", enemy)


func _on_entity_aiming_component_target_changed(target: Node2D) -> void:
	enemy = target
