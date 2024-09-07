class_name SingleDamageDealComponent
extends DamageDealComponent

#@export var collateral_damage: bool = false # wheter it can damage units when flying to the target
#@export var damage_radius:int = 1 # hwo much aoe it does in a hit
@export var damage_modifier = 1

# TO DO add checks for aoe damage
func deal_damage(reciever,  _center_position: Vector2 = self.global_position):
	#func _on_attack_timeout() -> void:
	if not is_instance_valid(reciever):
		return
	if !reciever or !reciever.health_component :
		push_error('reciever or reciever health component is null, my parrent is:', owner)
		# Apply damage to the enemy (assuming the enemy has a function named `take_damage`)
	elif !reciever.health_component.has_method("take_hit"):
		push_error('reciever health component doesnt have take dmg method, my parrent is:', owner)
		push_error('enemy health component', reciever.health_component)
	reciever.health_component.take_hit(base_damage*damage_modifier)
	
 
