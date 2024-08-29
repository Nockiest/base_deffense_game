class_name ProjectileStorage
extends Component

@export var stored_bullet: PackedScene
@export var capacity: int = 5
@export var start_ammo: int = 5
@export var load_time_sec: float = 2.0
@export var shoot_interval_sec: float = 0.25
@export var BulletsBar: BulletBar
#
# Current ammo count
var current_ammo: int: 
	set(value):
		current_ammo = value
		BulletsBar.change_value(value, capacity)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_ammo = start_ammo
	
 
func fire_bullet(_initial_rotation:float):
	pass
## Current ammo count
#var current_ammo: int: 
	#set(value):
		#current_ammo = value
		#$RemainingBulletsBar.change_value(value)
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#current_ammo = start_ammo
#
 #
#func expend_ammo() -> Variant:
	#return $StateMachine.state.expend_ammo()

	
