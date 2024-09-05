class_name Building
extends StaticBody2D


@onready var self_destruction_component: SelfDestructionComponent = $SelfDestructionComponent
@onready var health_component: HealthComponent = $HealthComponent


func _on_health_component_hp_ran_out() -> void:
	self_destruction_component.kill_owner()
