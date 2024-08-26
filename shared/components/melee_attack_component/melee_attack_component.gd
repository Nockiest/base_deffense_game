class_name MeleeAttackComponent
extends Node2D

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
	attack_timer.connect("timeout", _on_attack_timeout)
	add_child(attack_timer)
	
	# Ensure that an enemy is assigned
	if not enemy:
		print("No enemy assigned to MeleeAttackComponent!")

func _process(_delta: float) -> void:
	if enemy:
		# Calculate the distance to the enemy
		var distance_to_enemy = global_position.distance_to(enemy.global_position)
		
		# If the enemy is within range and the timer is not running, start the attack process
		if distance_to_enemy <= attack_range_px and not attack_timer.is_stopped():
			attack_timer.start()
			damage_deal_component.deal_damage(enemy)
	else:
		print("No enemy assigned or enemy not in range!")

func _on_attack_timeout() -> void:
	# This function is called when the attack delay timer times out
	if enemy:
		# Apply damage to the enemy (assuming the enemy has a function named `take_damage`)
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage_amount)
			print("Enemy hit for", damage_amount, "damage!")
		else:
			print("Enemy does not have a 'take_damage' function!")
	else:
		print("Enemy no longer in range!")
