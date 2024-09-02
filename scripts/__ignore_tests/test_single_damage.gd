extends "res://addons/gut/test.gd"

# Test nodes
var health_component
var single_damage_effect
var valid_entity

# Runs before each test
func before_each():
	# Create and configure the HealthComponent
	health_component = Test.instantiate_health_comp()
	
	# Create and configure the SingleDamage effect
	single_damage_effect = Test.instantiate_single_damage()
	single_damage_effect.damage = 20  # Set the damage amount
	single_damage_effect.effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT  # Ensure it's a one-shot effect
	
	# Set up the effect to target the HealthComponent
	single_damage_effect.owner = health_component
	health_component.add_child(single_damage_effect)

# Test that the SingleDamage effect deals damage and queues itself free
func test_single_damage_effect():
	# Trigger the effect
	single_damage_effect.cause_start_effect()
	
	# Verify that the health component's HP has decreased by the damage amount
	var expected_hp = 100 - single_damage_effect.damage
	assert_eq(health_component.current_hp, expected_hp, "Health should be reduced by the damage amount")
	
	# Verify that the SingleDamage effect has queued itself free
	assert_false(single_damage_effect.is_in_group("node"), "SingleDamage effect should be removed from the scene")

# Cleanup after tests
func after_each():
	if health_component:
		health_component.queue_free()
	if single_damage_effect:
		single_damage_effect.queue_free()
