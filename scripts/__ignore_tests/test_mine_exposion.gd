extends "res://addons/gut/test.gd"

# Test nodes and components
var mine:Mine
var enemy: Enemy
var effect_hold_component: EffectHoldComponent
var health_component:HealthComponent
 
func before_each():
	# Initialize and set up the mine and enemy
	mine =  Mine.new() #Mine.new()
	mine.single_damage_component = SingleDamage.new()
	mine.area_of_effect_component = AreaOfEffectComponent.new()
	
	enemy = Enemy.new()
	enemy.health_component = HealthComponent.new()
	enemy.health_component.effect_hold_component = EffectHoldComponent.new()
	enemy.add_to_group("enemies")
	# Add spies to the health component's take_hit function
	#enemy.health_component.spy_on("take_hit")

func  test_mine_damages_enemy():
	print_tree()
	print_debug(get_tree()," ", get_tree().get_nodes_in_group)
	# Arrange: Configure mine's area of effect and position
	mine.area_of_effect_component.effect_radius_px = 1000  # Large enough radius_px to include the enemy
	mine.global_position = Vector2(0, 0)
	mine.single_damage_component.damage = 1
	add_child(mine)

	# Arrange: Position enemy within mine's area of effect
	enemy.global_position = Vector2(0, 0)
	add_child(enemy)

	# Act: Simulate the enemy entering the mine's area
	mine._on_explosion_finished("explosion")

	# Assert: Check that take_hit was called with the correct damage amount
	assert_called(enemy.health_component, "take_hit", [1], )
