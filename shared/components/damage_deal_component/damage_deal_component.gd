class_name DamageDealComponent
extends Node2D

#@export var collateral_damage: bool = false # wheter it can damage units when flying to the target
@export var base_damage:int = 1 # hwo much damage it does in a hit
#@export var damage_radius:int = 1 # hwo much damage it does in a hit
 

# TO DO add checks for aoe damage
func deal_damage(reciever:Node):
	reciever.health_component.take_hit(base_damage)
	
 
