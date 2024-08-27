class_name SingleDamageDealComponent
extends DamageDealComponent

#@export var collateral_damage: bool = false # wheter it can damage units when flying to the target
#@export var damage_radius:int = 1 # hwo much aoe it does in a hit
 

# TO DO add checks for aoe damage
func deal_damage(reciever, damagable_object_groups: Array,center_position: Vector2 = self.global_position):
	#func _on_attack_timeout() -> void:
	## This function is called when the attack delay timer times out
	if not is_instance_valid(reciever):
		return
	if !reciever or !reciever.health_component :
		printerr('reciever or reciever health component is null, my parrent is:', owner)
		# Apply damage to the enemy (assuming the enemy has a function named `take_damage`)
	elif !reciever.health_component.has_method("take_hit"):
		printerr('reciever health component doesnt have take dmg method, my parrent is:', owner)
		printerr('enemy health component', reciever.health_component)
	reciever.health_component.take_hit(base_damage)
	
 
