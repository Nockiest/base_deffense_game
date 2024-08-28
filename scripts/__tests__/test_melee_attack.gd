extends "res://addons/gut/test.gd"

# Test nodes
var enemy
var turret
var melee_attack_component
var health_component_turret

# Runs before each test
func before_each():
	# Create the enemy node and its components
	enemy = Enemy.new()
	enemy.position = Vector2(0, 0)  # Position enemy at origin
	
	# Create and attach components to the enemy
	melee_attack_component = MeleeAttackComponent.new()
	melee_attack_component.attack_range_px = 500.0  # Set the attack range
	melee_attack_component.attack_delay_sec = 0.1  # Set a short delay for testing
	enemy.add_child(melee_attack_component)
	
	# Create and assign a mock DamageDealComponent
	var damage_deal_component = preload("res://scripts/components/damage/single_entity_damage/single_damage_component.tscn").instantiate()
	damage_deal_component.base_damage = 10
	melee_attack_component.damage_deal_component = damage_deal_component
	
	# Create the turret node and its components
	turret = Turret.new()
	turret.position = Vector2(40, 0)  # Position turret within the attack range
	add_child(turret)  # Add turret to the scene

	# Create and attach HealthComponent to the turret
	health_component_turret = HealthComponent.new()
	health_component_turret.max_hp = 100
	health_component_turret.start_hp = 100
	turret.add_child(health_component_turret)
	turret.health_component = health_component_turret

	# Ensure health component is ready
	health_component_turret._ready()
	assert_eq(health_component_turret.current_hp, 100, "Health should start at 100")

	# Set the turret as the enemy for the MeleeAttackComponent
	melee_attack_component.enemy = turret

	# Add enemy to the scene
	add_child(enemy)

# Test that the melee attack component deals damage to the turret
func test_melee_attack_damage():
	# Simulate one process frame with delta time
	melee_attack_component.damage_deal_component.deal_damage(turret, ['turrets'])

	# Check if the turret's health decreased by the damage amount
	var expected_hp = 90  # 100 (initial) - 10 (damage amount)
	print("Turret health after attack:", turret.health_component.current_hp)
	assert_eq(turret.health_component.current_hp, expected_hp, "Turret should take damage from melee attack")

# Cleanup after tests
func after_each():
	if enemy:
		enemy.queue_free()
	if turret:
		turret.queue_free()
