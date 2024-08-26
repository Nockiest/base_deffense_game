class_name HealthComponent
extends Node2D

@export var max_hp: int = 1
@export var start_hp: int = 1
@export var max_shields: int = 1
@export var start_shields: int = 1
@export var regeneration_per_call: int = 1

@export var health_bar: ProgressBar  # Reference to the health ProgressBar
@export var shield_bar: ProgressBar   # Reference to the shield ProgressBar

signal hp_ran_out()
signal health_stat_changed(current_hp, current_shields)
signal shields_ran_out()

# Define the current HP and shields with setter functions
var current_hp: int = start_hp:
	set(new_hp):
		current_hp = clampi(new_hp, 0, max_hp)
		update_progress_bars()  # Update shield bar when value changes
		if new_hp <= 0:
			emit_signal("hp_ran_out")
		emit_signal("health_stat_changed", current_hp, current_shields)
		print("current health is", current_hp)

var current_shields: int = start_shields:
	set(new_shields):
		current_shields = clampi(new_shields, 0, max_shields)
		update_progress_bars()  # Update shield bar when value changes
		if new_shields <= 0:
			emit_signal("shields_ran_out")
		emit_signal("health_stat_changed", current_hp, current_shields)
		print("current shields are", current_shields)

# Called every frame. '_delta' is the elapsed time since the previous frame.
func take_hit(dmg: int) -> void:
	print(owner, ' took hit', dmg, current_hp, current_shields)
	if current_shields > 0:
		# If there are shields, subtract damage from shields
		current_shields -= dmg
	else:
		# If no shields, subtract damage from health
		current_hp -= dmg
		# Check if health ran out

func take_armor_piercing_damage(dmg: int) -> void:
	current_hp -= dmg

func regenerate(amount: int = regeneration_per_call) -> void:
	current_hp = clampi(current_hp + amount, 0, max_hp)

# Update functions for ProgressBars
func update_progress_bars() -> void:
	if health_bar:
		health_bar.value = current_hp
		health_bar.max_value = max_hp
	if shield_bar:
		shield_bar.value = current_shields
		shield_bar.max_value = max_shields

# Add functions to retrieve current health and shields if needed
func get_current_health() -> int:
	return current_hp
	
func get_current_shields() -> int:
	return current_shields

func _ready() -> void:
	update_progress_bars()

 
