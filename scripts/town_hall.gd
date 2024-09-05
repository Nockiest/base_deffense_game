class_name TownHall
extends StaticBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var self_destruction_component: SelfDestructionComponent = $SelfDestructionComponent

 
func _on_health_component_hp_ran_out() -> void:
	print('hp ran out')
	Globals.game_lost = true
	self_destruction_component.kill_owner()
