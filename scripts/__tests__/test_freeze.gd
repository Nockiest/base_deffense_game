extends "res://addons/gut/test.gd"

# Test nodes and components
var effect: FreezeEffect
var enemy: Node2D
 
var movement_component:MovementComponent



func before_each() -> void:
	# Initialize the effect and set allowed classes
	effect = FreezeEffect.new()
	effect.duration_sec = 0.3
	enemy = Enemy.new()
	movement_component =  MovementComponent.new()
	movement_component.base_speed_per_frame = 10
	enemy.movement_component = movement_component 
	# Add entities to the scene for testing
	add_child(enemy)
	
	effect.apply_to_entity(enemy) 
	
func test_freeze_mount():
	# Process a frame to ensure the effect application is handled
	enemy._process(0.1)
	# Check if any child of the effect holder is of the same type as the effect
	var effect_type_match_found = Test.has_copy( effect,movement_component.effect_hold_component)
	# Assert that an effect of the correct type was added
	assert_true(effect_type_match_found, "An effect of the same type should be added to the enemys EffectHoldComponent.")
	
func test_freeze_applied():
	# Process a frame to ensure the effect application is handled
	enemy._process(0.1)
	# Check if any child of the effect holder is of the same type as the effect
	var effect_type_match_found = Test.has_copy( effect,movement_component.effect_hold_component)
	# Assert that an effect of the correct type was added
	print(enemy.movement_component.base_speed_per_frame)
	assert_true(enemy.movement_component.base_speed_per_frame == 0, "enemy should be stopped.")

func test_freeze_unmount():
	# Process a frame to ensure the effect application is handled
	enemy._process(1)
	# Check if any child of the effect holder is of the same type as the effect
	var effect_type_match_found = Test.has_copy( effect,movement_component.effect_hold_component)
	# Assert that an effect of the correct type was added
	print(enemy.movement_component.base_speed_per_frame)
	assert_true(enemy.movement_component.base_speed_per_frame != 0, "enemy should resume movement")
	assert_false(Test.has_copy( effect,movement_component.effect_hold_component), "effect should be unmounted from enemy")
