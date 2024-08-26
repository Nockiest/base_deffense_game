class_name AmmoMagazine
extends Node2D

@export var capacity: int = 5
@export var start_ammo: int = 5
@export var stored_bullet: PackedScene
@export var load_time_sec: float = 2.0

# Current ammo count
var current_ammo: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_ammo = start_ammo

# Load a single ammo after the load time has passed
func load_ammo() -> void:
	# Check if there is room in the magazine
	if current_ammo < capacity:
		# Use a Timer to wait for load_time_sec
		await get_tree().create_timer(load_time_sec).timeout
		# Increase the current ammo count
		current_ammo  =  capacity
		
		print("Ammo loaded. Current ammo: ", current_ammo)
	else:
		print("Magazine is full.")

func expend_ammo() -> Variant:
	if current_ammo <= 0:
		return null
	
	current_ammo -= 1
	print('Expended ammo, current ammo:', current_ammo)
	return stored_bullet

# Example usage: load one bullet every 2 seconds
#func _process(delta: float) -> void:
	#if current_ammo < capacity:
		#load_ammo()
