extends "res://addons/gut/test.gd"

# Test nodes and components
var effect: BaseEffect
var valid_entity: Node2D
var invalid_entity: Node2D
var effect_hold_component_valid: EffectHoldComponent
var effect_hold_component_invalid: EffectHoldComponent
var health_component:HealthComponent


func before_each() -> void:
	# Initialize the effect and set allowed classes
	effect = Test.instantiate_effect([ 'HealthComponent' ])
	health_component =  Test.instantiate_health_comp()
	effect_hold_component_valid = preload("res://scripts/components/effect_holder_component/effect_hold_component.tscn").instantiate()
	health_component.add_child(effect_hold_component_valid)
	health_component.effect_hold_component = effect_hold_component_valid
	valid_entity = Test.instantiate_enemy()
	valid_entity.health_component = health_component
	valid_entity.add_child(health_component)
	effect_hold_component_valid = health_component.effect_hold_component
	invalid_entity = Node2D.new()
	invalid_entity.set_script(preload("res://scripts/components/aiming/base_aiming_component.gd"))  # Mock script class name: "InvalidClass"
	effect_hold_component_invalid = EffectHoldComponent.new()
	invalid_entity.add_child(effect_hold_component_invalid)

	# Add entities to the scene for testing
	add_child(valid_entity)
	add_child(invalid_entity)
	await get_tree().process_frame #, "idle_frame"
func test_apply_to_valid_entity() -> void:
	# Apply the effect to the valid entity
	prints( valid_entity,valid_entity.health_component, valid_entity.health_component.effect_hold_component, effect_hold_component_valid  )
	effect.apply_to_entity(valid_entity)
	print("1",effect.can_apply_on_node(valid_entity.health_component),effect_hold_component_valid,effect_hold_component_valid.get_children())
	# Check if any child of the effect holder is of the same type as the effect
	var effect_type_match_found = Test.has_copy( effect,effect_hold_component_valid)
	
	# Assert that an effect of the correct type was added
	assert_true(effect_type_match_found, "An effect of the same type should be added to the valid entity's EffectHoldComponent.")

func test_one_shot_effect() -> void:
	# Test if a one-shot effect triggers correctly and then is removed
	effect.effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT
	effect.apply_to_entity(valid_entity)
	var effect_type_match_found = Test.has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "One-shot effect should be triggered")
	await get_tree().create_timer(0.3).timeout  # Wait until the effect duration ends
	effect_type_match_found = Test.has_copy( effect,effect_hold_component_valid)
	print(effect_hold_component_valid.get_children())
	assert_false(effect_type_match_found, "One-shot effect should be removed after triggering")

func test_per_second_effect() -> void:
	# Test if a per-second effect triggers repeatedly
	effect.effect_type = EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND
	effect.effect_interval = 0.1
	effect.duration_sec = 1
	effect.apply_to_entity(valid_entity)
	await get_tree().create_timer(0.2).timeout  # Wait for the effect to trigger multiple times
	print(effect, effect_hold_component_valid.get_children())
	
	var   effect_type_match_found =  Test.has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "Per-second effect should be active")
func test_on_and_off_effect() -> void:
	# Test if an on-and-off effect triggers correctly and is removed after the duration
	effect.effect_type = EffectTypes.EFFECT_TYPE.ON_AND_OFF
	effect.duration_sec = 0.3
	effect.apply_to_entity(valid_entity)
	print('x',effect_hold_component_valid.get_children())
	prints( valid_entity.name, valid_entity.has_node("EffectHoldComponent") ,   valid_entity.name in effect.applicable_components ,false)
	await get_tree().create_timer(0.1).timeout  # Wait during the effect duration
	var  effect_type_match_found = Test.has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "On-and-off effect should be active")
	await get_tree().create_timer(0.3).timeout  # Wait until the effect duration ends
	print('y',effect_hold_component_valid.get_children())
	effect_type_match_found = Test.has_copy( effect,effect_hold_component_valid)
	assert_false(effect_type_match_found, "on_and_off effect should be active")

func test_fire_effect_on_enemy() -> void:
	# Create and configure a FireEffect instance
	var fire_effect = FireEffect.new()
	fire_effect.effect_type = EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND
	fire_effect.fire_damage_sec = 1
	fire_effect.duration_sec = 3

	# Create a valid enemy entity with a HealthComponent
	var health_component = Test.instantiate_health_comp()
	health_component.max_hp = 100
	health_component.start_hp = 100

	var enemy = Test.instantiate_enemy()
	enemy.add_child(health_component)  # Add HealthComponent to enemy
	enemy.health_component = health_component
	add_child(enemy)  # Add enemy to the scene tree for testing

	# Apply the FireEffect to the enemy
	fire_effect.apply_to_entity(enemy)
	enemy._process(0.01)
	# Verify that the effect is mounted on the enemy's HealthComponent
	print( enemy.health_component.get_node('EffectHoldComponent'),Test.has_copy(fire_effect, enemy.health_component.get_node('EffectHoldComponent') ), enemy.health_component.get_node('EffectHoldComponent').get_children())
	var effect_type_match_found = Test.has_copy(fire_effect, enemy.health_component.get_node('EffectHoldComponent'))
	assert_true(effect_type_match_found, "FireEffect should be mounted on the enemy's HealthComponent.")

	# Wait for half of the effect's duration and verify damage has been applied
	await get_tree().create_timer(4).timeout
	print(enemy.health_component.current_hp, Test.has_copy(fire_effect, enemy.health_component.get_node('EffectHoldComponent') ))
	assert_true(enemy.health_component.current_hp== 97, "Enemy HP should decrease by fire damage after half the effect duration.")


	# Verify the effect unmounts after the effect duration ends
	effect_type_match_found = Test.has_copy(fire_effect, health_component.get_node('EffectHoldComponent'))
	assert_false(effect_type_match_found, "FireEffect should be unmounted after the duration ends.")

# Cleanup after each test
func after_each() -> void:
	if is_instance_valid(valid_entity):
		valid_entity.queue_free()
		valid_entity = null
	if is_instance_valid(invalid_entity):
		invalid_entity.queue_free()
		invalid_entity = null
	if is_instance_valid(effect):
		effect.queue_free()
		effect = null
	if is_instance_valid(effect_hold_component_valid):
		effect_hold_component_valid.queue_free()
		effect_hold_component_valid = null
	if is_instance_valid(effect_hold_component_invalid):
		effect_hold_component_invalid.queue_free()
		effect_hold_component_invalid = null
 
