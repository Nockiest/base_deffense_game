# TestEntityAimingComponent.gd
extends "res://addons/gut/test.gd"

# Load the scene or script for the EntityAimingComponent
var aiming_component =   EntityAimingComponent.new()

func _before_each():
	# Add the aiming component to the test scene
	#var aiming_component =  AimingComponent.new()
	# Set up the test group name
	var aiming_entity = Enemy.new()
	
	aiming_entity.add_child(aiming_component)
	add_child(aiming_entity)
	aiming_component.enemy_group = "turrets"
	
	# Create two turret nodes as targets
	var turret1 = Node2D.new()
	turret1.name = "Turret1"
	turret1.position = Vector2(100, 100)  # Set position for turret1
	add_child(turret1)
	turret1.add_to_group("turrets")

	var turret2 = Node2D.new()
	turret2.name = "Turret2"
	turret2.position = Vector2(300, 300)  # Set position for turret2
	add_child(turret2)
	turret2.add_to_group("turrets")

	await get_tree().process_frame 
# Test that the component aims at the nearest turret position
func test_aims_at_nearest_turret():
	# Update target position to find nearest turret
	aiming_component.enemy_group = "turrets"
	prints(aiming_component, "x", aiming_component.enemy_group)
	
	var enemy = aiming_component.get_nearest_enemy("turrets")
	
	# Assert the current target is the nearest turret (turret1 in this case)
	assert_true(enemy.position ==  Vector2(100, 100), "A target should be found.")
	assert_eq  (aiming_component.target_position , Vector2(100, 100), "The nearest turret should be Turret1.")

# Test that it aims at the closer of two turret positions if positions change
#func test_switches_to_closer_turret():
	## Get tu"."rret nodes
	#print(get_tree().get_children())
	#var turret1 = get_node("Turret1")
	#var turret2 = get_node("Turret2")
#
	## Move turret1 further away
	#turret1.position = Vector2(500, 500)
#
	## Move turret2 closer
	#turret2.position = Vector2(50, 50)
	#print(aiming_component, aiming_component.enemy_group)
	## Update target position again
	#aiming_component.update_target_position()
#
	## Assert the current target has switched to the closer turret (turret2 in this case)
	#assert_true(aiming_component.current_target != null, "A target should be found.")
	#assert_true(aiming_component.current_target.name == "Turret2", "The closest turret should now be Turret2.")
