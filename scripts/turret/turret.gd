extends Placable
class_name Turret


 
func _on_health_component_hp_ran_out() -> void:
	self_destruction_component.kill_owner()
