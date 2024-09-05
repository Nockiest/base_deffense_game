extends Placable
class_name Turret

@export var aiming_component: AimingComponent
@export var ammo_magazine_component: ProjectileStorage
 
 
func _on_health_component_hp_ran_out() -> void:
	self_destruction_component.kill_owner()
