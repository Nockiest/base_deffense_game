extends "res://addons/gut/test.gd"

# Test nodes
var effect_hold_component
var effect_1
var effect_2

# Runs before each test
func before_each():
	# Create the EffectHoldComponent instance
	effect_hold_component = EffectHoldComponent.new()
	add_child(effect_hold_component)

	# Create mock effects (assuming BaseEffect is a valid class)
	effect_1 = BaseEffect.new()
	effect_1.name = "FireEffect"

	effect_2 = BaseEffect.new()
	effect_2.name = "FreezeEffect"

# Test adding effects
func test_add_effect():
	effect_hold_component.add_effect(effect_1)
	assert_true(effect_1 in effect_hold_component.get_children(), "Effect 1 should be added")

	effect_hold_component.add_effect(effect_2)
	assert_true(effect_2 in effect_hold_component.get_children(), "Effect 2 should be added")

# Test removing effects
func test_remove_effect():
	# Add effects first
	effect_hold_component.add_effect(effect_1)
	effect_hold_component.add_effect(effect_2)

	# Remove the first effect and check
	effect_hold_component.remove_effect(effect_1)
	assert_false(effect_1 in effect_hold_component.get_children(), "Effect 1 should be removed")

	# Remove the second effect and check
	effect_hold_component.remove_effect(effect_2)
	assert_false(effect_2 in effect_hold_component.get_children(), "Effect 2 should be removed")

# Cleanup after tests
func after_each():
	if effect_hold_component:
		effect_hold_component.queue_free()
	if effect_1:
		effect_1.queue_free()
	if effect_2:
		effect_2.queue_free()
