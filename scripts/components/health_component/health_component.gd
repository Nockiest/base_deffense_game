class_name HealthComponent
extends NodeModClass

func get_type_name():
	return 'HealthComponent'
@export var max_hp: float = 1
@export var start_hp: float = 1
@export var max_shields: float = 1
@export var start_shields: float = 1
@export var regeneration_per_call: float = 1

@export var health_bar: ProgressBar  # Reference to the health ProgressBar
@export var shield_bar: ProgressBar   # Reference to the shield ProgressBar
@export var effect_holder: EffectHoldComponent  


signal hp_ran_out()
signal health_stat_changed(current_hp, current_shields)
signal shields_ran_out()

# Define the current HP and shields with setter functions
var current_hp: float = 0.0:
	set(new_hp):
		current_hp = clamp(new_hp, 0, max_hp)  # Use clamp() instead of clampi() for float values
		update_progress_bars()  # Update shield bar when value changes
		if current_hp <= 0:
			emit_signal("hp_ran_out")
		emit_signal("health_stat_changed", current_hp, current_shields)
		print("Current health is", current_hp)

var current_shields: float = 0.0:
	set(new_shields):
		current_shields = clamp(new_shields, 0, max_shields)  # Use clamp() instead of clampi() for float values
		update_progress_bars()  # Update shield bar when value changes
		if current_shields <= 0:
			emit_signal("shields_ran_out")
		emit_signal("health_stat_changed", current_hp, current_shields)
		print("Current shields are", current_shields)

# Called every frame. '_delta' is the elapsed time since the previous frame.
func take_hit(dmg: float) -> void:
	print(owner, " took hit:", dmg, " HP:", current_hp, " Shields:", current_shields)
	if current_shields > 0:
		current_shields -= dmg
	else:
		current_hp -= dmg

func take_armor_piercing_damage(dmg: float) -> void:
	current_hp -= dmg

func regenerate(amount: float = regeneration_per_call) -> void:
	current_hp = clamp(current_hp + amount, 0, max_hp)

# Update functions for ProgressBars
func update_progress_bars() -> void:
	if health_bar:
		health_bar.value = current_hp
		health_bar.max_value = max_hp
	if shield_bar:
		shield_bar.value = current_shields
		shield_bar.max_value = max_shields

# Add functions to retrieve current health and shields if needed
func get_current_health() -> float:
	return current_hp
	
func get_current_shields() -> float:
	return current_shields

func _ready() -> void:
	# Properly initialize current_hp and current_shields
	current_hp = start_hp
	current_shields = start_shields
	update_progress_bars()
	
func _process(delta: float) -> void:
	pass
