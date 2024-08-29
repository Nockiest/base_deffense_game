extends "res://addons/gut/test.gd"

# Test nodes
var bullet
var enemy
var health_component_enemy
var single_damage_effect

# Runs before each test
func before_each():
	# Create and configure the Enemy
	enemy = Test.instantiate_enemy()
	enemy.position = Vector2(0, 0)  # Position enemy at origin
	
	# Create and configure the Bullet
	bullet = Test.instantiate_bullet()
	bullet.position = Vector2(0, 0)  # Start bullet at origin
	
	# Create and configure the SingleDamage effect
	single_damage_effect = SingleDamage.new()
	single_damage_effect.damage = 20
	single_damage_effect.effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT
	single_damage_effect.owner = enemy  # Set the owner of the effect to the enemy
	
	# Attach the effect to the Bullet's effects array
	bullet.effects.append(single_damage_effect)
	
	health_component_enemy = Test.instantiate_health_comp()
	enemy.health_component = health_component_enemy
	# Add Bullet and Enemy to the scene
	add_child(bullet)
	add_child(enemy)

# Test that the SingleDamage effect is applied correctly and the Enemy's HP is reduced
func test_bullet_applies_effect():
	# Simulate the bullet hitting the enemy
	bullet._on_area_entered(enemy)  # Trigger the collision handler
	var has_copy = Test.has_copy( single_damage_effect,health_component_enemy)
	# Verify that the SingleDamage effect was applied to the enemy
	assert_true(has_copy, "SingleDamage effect should be mounted to the enemy")
	
	# Verify that the enemy's HP has decreased by the damage amount
	var expected_hp = 100 - single_damage_effect.damage
	assert_eq(enemy.get_node("HealthComponent").current_hp, expected_hp, "Enemy's health should be reduced by the damage amount")

# Cleanup after tests
func after_each():
	if bullet:
		bullet.queue_free()
	if enemy:
		enemy.queue_free()
	if single_damage_effect:
		single_damage_effect.queue_free()
