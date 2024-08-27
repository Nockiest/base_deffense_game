extends Node2D

class_name Turret

@export var aiming_component: AimingComponent
@export var ammo_magazine_component: ProjectileStorage
@export var health_component: HealthComponent
@export var self_destruction_component: SelfDestructionComponent
 
func _on_health_component_hp_ran_out() -> void:
	self_destruction_component.kill_owner()
