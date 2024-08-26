class_name AmmoMagazine
extends Node2D

@export var capacity: int = 5
@export var start_ammo: int = 5
@export var stored_bullet: PackedScene
@export var load_time_sec: float = 2.0

# Current ammo count
var current_ammo: int: 
	set(value):
		current_ammo = value
		$RemainingBulletsBar.value = float(current_ammo) / float(capacity) * 100
		$RemainingBulletsBar/Label.text = str(current_ammo) + "/" + str(capacity)
# Update the progress bar based on current ammo and capacity
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_ammo = start_ammo

# Load a single ammo after the load time has passed
func load_ammo() -> void:
	if $StateMachine.state == $StateMachine/Loaded:
		$StateMachine.transition_to('Loading')
 

func expend_ammo() -> Variant:
	return $StateMachine.state.expend_ammo()
	

# Example usage: load one bullet every 2 seconds
#func _process(delta: float) -> void:
	#if current_ammo < capacity:
		#load_ammo()
