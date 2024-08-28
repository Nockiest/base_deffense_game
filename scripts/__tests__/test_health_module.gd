extends GutTest

# Reference the HealthComponent script
var __source =   "res://scripts/components/health_component/health_component.gd" 

# Setup the test case
func test_health_component_initialization():
	var health_component = HealthComponent.new()
	health_component.max_hp = 100
	health_component.start_hp = 100
	health_component.max_shields = 50
	health_component.start_shields = 50
	health_component.regeneration_per_call = 5
	
	# Assign dummy ProgressBars (optional)
	health_component.health_bar = ProgressBar.new()
	health_component.shield_bar = ProgressBar.new()

	# Initialize the component
	health_component._ready()
	
	# Test initial values
	print(health_component.current_hp, " ", 100)
	assert_eq(health_component.current_hp, 100, "Initial health should be 100")
	assert_eq(health_component.current_shields, 50, "Initial shields should be 50")

func test_take_hit():
	var health_component =  HealthComponent.new()
	health_component.max_hp = 100
	health_component.start_hp = 100
	health_component.max_shields = 50
	health_component.start_shields = 50
	
	# Initialize the component
	health_component._ready()
	
	# Simulate taking a hit that reduces shields
	health_component.take_hit(20)
	assert_eq(health_component.current_shields, 30, "Shields should be reduced to 30")
	assert_eq(health_component.current_hp, 100, "Health should remain 100")
	
	# Simulate taking another hit that reduces health
	health_component.take_hit(40)
	assert_eq(health_component.current_shields, 0, "Shields should be depleted to 0")
	assert_eq(health_component.current_hp, 100, "Health should be reduced to 90")
	
	health_component.take_hit(40)
	assert_eq(health_component.current_shields, 0, "Shields should be depleted to 0")
	assert_eq(health_component.current_hp, 60, "Health should be reduced to 90")
	health_component.queue_free()

func test_take_armor_piercing_hit():
	var health_component =  HealthComponent.new()
	health_component.max_hp = 100
	health_component.start_hp = 100
	
	# Initialize the component
	health_component._ready()
	
	# Simulate taking armor-piercing damage
	health_component.take_armor_piercing_damage(30)
	print(health_component.current_hp, " ", 70,)
	assert_eq(health_component.current_hp, 70, "Health should be reduced to 70")
	health_component.queue_free()

func test_regeneration():
	var health_component =  HealthComponent.new()
	health_component.max_hp = 100
	health_component.start_hp = 50
	
	# Initialize the component
	health_component._ready()
	
	# Simulate regeneration
	health_component.regenerate(25)
	assert_eq(health_component.current_hp, 75, "Health should be increased to 75")
	health_component.queue_free()

# Register the test cases
#func _register_tests():
	#add_test("HealthComponent - Initialization", self.test_health_component_initialization)
	#add_test("HealthComponent - Take Hit", self.test_take_hit)
	#add_test("HealthComponent - Armor Piercing Hit", self.test_take_armor_piercing_hit)
	#add_test("HealthComponent - Regeneration", self.test_regeneration)

#_register_tests()
