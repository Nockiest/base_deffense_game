extends Node

func instantiate_health_comp():
	var health_component_scene = preload("res://scripts/components/health_component/health_component.tscn")  # Replace with your actual path
	var health_component = health_component_scene.instantiate()
	health_component.set_script(preload("res://scripts/components/health_component/health_component.gd"))  # Mock script class name: "ValidClass"
	return health_component 
	# Initialize the effect and set allowed classes
	

static func instantiate_effect(effect_allowed_types: Array[String]) -> BaseEffect:
	var effect = BaseEffect.new()
	effect.effect_type = EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND
	effect.effect_interval = 1.0  # Set interval for per-second effect
	effect.duration = 5.0  # Set effect duration
	effect.allowed_types = effect_allowed_types # Specify allowed class names for the effect
	return effect

func instantiate_enemy()-> Enemy:
	var enemy_scene = preload("res://scenes/enemies/basic_enemy.tscn")  # Replace with your actual path
	var enemy = enemy_scene.instantiate()
	enemy.set_script(preload("res://scripts/enemies/basic_enemy.gd"))  # Mock script class name: "ValidClass"
	return enemy 

func instantiate_bullet()-> Bullet:
	var bullet_scene = preload("res://scenes/projectiles/bullet/bullet.tscn")  # Replace with your actual path
	var bullet = bullet_scene.instantiate()
	bullet.set_script(preload("res://scripts/projectiles/bullet/bullet.gd"))  # Mock script class name: "ValidClass"
	return bullet 

func instantiate_single_damage()-> SingleDamage:
	var dmg_scene = preload("res://scenes/effects/single_damage/single_damage.tscn")  # Mock script class name: "ValidClass"
	var dmg = dmg_scene.instantiate()
	dmg.set_script(preload("res://scripts/effects/single_damage.gd"))  # Mock script class name: "ValidClass"
	return dmg  
# Utility function to instantiate a node from a scene and set its script
#func instantiate_node(scene_path: String, script_path: String) -> Node:
	#var scene = load(scene_path)
	#if scene == null:
		#printerr("Failed to load scene from path: ", scene_path)
		#return null
	#
	#var node = scene.instantiate()
	#if node == null:
		#printerr("Failed to instantiate node from scene: ", scene_path)
		#return null
	#
	#var script = load(script_path)
	#if script == null:
		#printerr("Failed to load script from path: ", script_path)
		#return null
#
	#node.set_script(script)
	#return node
