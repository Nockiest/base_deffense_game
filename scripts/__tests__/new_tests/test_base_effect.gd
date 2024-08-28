extends "res://addons/gut/test.gd"

# Test nodes and components
var effect: BaseEffect
var valid_entity: Node2D
var invalid_entity: Node2D
var effect_hold_component_valid: EffectHoldComponent
var effect_hold_component_invalid: EffectHoldComponent

func has_copy( eff:BaseEffect,node:Node)->bool:
	var   effect_type_match_found = false
	for child in node.get_children():
		if not child.has_method("get_type_name"):
			continue
		if child.get_type_name() == effect.get_type_name():
			effect_type_match_found = true
			break
	return effect_type_match_found

func before_each() -> void:
	# Initialize the effect and set allowed classes
	effect = Test.instantiate_effect([ 'HealthComponent' ])
	valid_entity = Test.instantiate_enemy()
	effect_hold_component_valid = valid_entity.get_node( 'HealthComponent' ).get_node('EffectHoldComponent')
	# Create an invalid entity with an EffectHoldComponent and a non-matching script class
	invalid_entity = Node2D.new()
	invalid_entity.set_script(preload("res://scripts/components/aiming/base_aiming_component.gd"))  # Mock script class name: "InvalidClass"
	effect_hold_component_invalid = EffectHoldComponent.new()
	invalid_entity.add_child(effect_hold_component_invalid)

	# Add entities to the scene for testing
	add_child(valid_entity)
	add_child(invalid_entity)

func test_apply_to_valid_entity() -> void:
	# Apply the effect to the valid entity
	effect.apply_to_entity(valid_entity)
	
	# Process a frame to ensure the effect application is handled
	valid_entity._process(0.1)

	# Check if any child of the effect holder is of the same type as the effect
	var effect_type_match_found = has_copy( effect,effect_hold_component_valid)
	# Assert that an effect of the correct type was added
	assert_true(effect_type_match_found, "An effect of the same type should be added to the valid entity's EffectHoldComponent.")

func test_one_shot_effect() -> void:
	# Test if a one-shot effect triggers correctly and then is removed
	effect.effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT
	effect.apply_to_entity(valid_entity)
	var effect_type_match_found = has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "One-shot effect should be triggered")
	valid_entity._process(0.1)
	effect_type_match_found = has_copy( effect,effect_hold_component_valid)
	assert_false(effect_type_match_found, "One-shot effect should be removed after triggering")

func test_per_second_effect() -> void:
	# Test if a per-second effect triggers repeatedly
	effect.effect_type = EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND
	effect.effect_interval = 0.1
	effect.duration_sec = 1
	effect.apply_to_entity(valid_entity)
	await get_tree().create_timer(0.2).timeout  # Wait for the effect to trigger multiple times
	print(effect, effect_hold_component_valid.get_children())
	
	var   effect_type_match_found =  has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "Per-second effect should be active")
func test_on_and_off_effect() -> void:
	# Test if an on-and-off effect triggers correctly and is removed after the duration
	effect.effect_type = EffectTypes.EFFECT_TYPE.ON_AND_OFF
	effect.duration_sec = 0.3
	effect.apply_to_entity(valid_entity)
	print('x',effect_hold_component_valid.get_children())
	Utils.print_spaced([valid_entity.get_type_name(), valid_entity.has_node("EffectHoldComponent") ,   valid_entity.get_type_name() in effect.allowed_types],false)
	await get_tree().create_timer(0.1).timeout  # Wait during the effect duration
	var  effect_type_match_found = has_copy( effect,effect_hold_component_valid)
	assert_true(effect_type_match_found, "On-and-off effect should be active")
	await get_tree().create_timer(0.3).timeout  # Wait until the effect duration ends
	print('y',effect_hold_component_valid.get_children())
	effect_type_match_found = has_copy( effect,effect_hold_component_valid)
	assert_false(effect_type_match_found, "on_and_off effect should be active")

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
 
