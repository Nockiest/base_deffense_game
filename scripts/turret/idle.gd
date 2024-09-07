extends State


func enter(_msg := {}):
	owner.auto_shoot_component.enabled = false



func _on_entity_aiming_component_target_changed(target: Node2D) -> void:
	print('target_changed', target, owner)
	if   target:
		state_machine.transition_to('Aiming')
