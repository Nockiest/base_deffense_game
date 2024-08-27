class_name DamageDealComponent
extends Node

@export var base_damage:int = 1 # hwo much damage it does in a hit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func deal_damage(reciever, damagable_object_groups: Array[String],center_position: Vector2 = self.global_position):
	pass
