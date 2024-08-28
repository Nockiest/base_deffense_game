extends "res://addons/gut/test.gd"

# Test nodes and components
var effect: BaseEffect
var valid_entity: Node2D
var invalid_entity: Node2D
var effect_hold_component_valid: EffectHoldComponent
var effect_hold_component_invalid: EffectHoldComponent

func before_each() -> void:
	# Initialize the effect and set allowed classes
	effect = BaseEffect.new()
	effect.effect_type = BaseEffect.EFFECT_TYPE.EFFECT_PER_SECOND
	effect.effect_interval = 1.0  # Set interval for per-second effect
	effect.duration = 5.0  # Set effect duration
	effect.allowed_types = [ 'HealthComponent' ]  # Specify allowed class names for the effect

	# Create a valid entity with an EffectHoldComponent and a matching script class
	var health_component_scene = preload("res://scripts/components/health_component/health_component.tscn")  # Replace with your actual path
	valid_entity = health_component_scene.instantiate()
	valid_entity.set_script(preload("res://scripts/components/health_component/health_component.gd"))  # Mock script class name: "ValidClass"
	print(effect_hold_component_valid,valid_entity.get_children())
	
	effect_hold_component_valid = valid_entity.get_node('EffectHoldComponent')
	#EffectHoldComponent.new()
	#valid_entity.add_child(effect_hold_component_valid)

	# Create an invalid entity with an EffectHoldComponent and a non-matching script class
	invalid_entity = Node2D.new()
	invalid_entity.set_script(preload("res://scripts/components/aiming/base_aiming_component.gd"))  # Mock script class name: "InvalidClass"
	effect_hold_component_invalid = EffectHoldComponent.new()
	invalid_entity.add_child(effect_hold_component_invalid)

	# Add entities to the scene for testing
	add_child(valid_entity)
	add_child(invalid_entity)

func test_apply_to_valid_entity() -> void:
	# Test if the effect can be applied to a valid class
	effect.apply_to_entity(valid_entity)
	#await get_tree().idle_frame  # Wait a frame to process
	invalid_entity._process(0.1)
	assert_true(effect in effect_hold_component_valid.get_children(), "Effect should be added to the valid entity")

func test_apply_to_invalid_entity() -> void:
	# Test if the effect is not applied to an invalid class
	effect.apply_to_entity(invalid_entity)
	#await get_tree().idle_frame  # Wait a frame to process
	invalid_entity._process(0.1)
	assert_false(effect in effect_hold_component_invalid.get_children(), "Effect should not be added to the invalid entity")

func test_one_shot_effect() -> void:
	# Test if a one-shot effect triggers correctly and then is removed
	effect.effect_type = BaseEffect.EFFECT_TYPE.ONE_SHOT
	effect.apply_to_entity(valid_entity)
	assert_true(effect in effect_hold_component_valid.get_children(), "One-shot effect should be triggered")
	valid_entity._process(0.1)
	await get_tree().create_timer(0.1).timeout  # Wait for the effect to finish
	assert_false(effect in effect_hold_component_valid.get_children(), "One-shot effect should be removed after triggering")

func test_per_second_effect() -> void:
	# Test if a per-second effect triggers repeatedly
	effect.effect_type = BaseEffect.EFFECT_TYPE.EFFECT_PER_SECOND
	effect.effect_interval = 0.1
	effect.apply_to_entity(valid_entity)
	await get_tree().create_timer(0.2).timeout  # Wait for the effect to trigger multiple times
	assert_true(effect in effect_hold_component_valid.get_children(), "Per-second effect should be active")
#func can_apply_on_entity(entity: Node) -> bool:
	#if !entity.has_node("effect_hold_component"):
		#printerr('Entity does not have effect_hold_component:', entity)
		#return false
	#var entity_script = entity.get_script()
	#for allowed in allowed_types:
		#if entity_script in allowed:
			#return true
		 #
	#printerr('Cannot apply effect to entity', entity, 'Allowed classes:', allowed_types)
	#return false
func test_on_and_off_effect() -> void:
	# Test if an on-and-off effect triggers correctly and is removed after the duration
	effect.effect_type = BaseEffect.EFFECT_TYPE.ON_AND_OFF
	effect.duration = 0.3
	effect.apply_to_entity(valid_entity)
	print(effect_hold_component_valid.get_children())
	Utils.print_spaced([valid_entity.get_type_name(), valid_entity.has_node("EffectHoldComponent") ,   valid_entity.get_type_name() in effect.allowed_types],false)
	await get_tree().create_timer(0.1).timeout  # Wait during the effect duration
	assert_true(effect in effect_hold_component_valid.get_children(), "On-and-off effect should be active")
	await get_tree().create_timer(0.3).timeout  # Wait until the effect duration ends
	print(effect_hold_component_valid.get_children())
	assert_false(effect in effect_hold_component_valid.get_children(), "On-and-off effect should be removed after the duration")

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
