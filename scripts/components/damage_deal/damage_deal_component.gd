class_name DamageDealComponent
extends Component

@export var base_damage:float = 1 # hwo much damage it does in a hit
@export var modifier:float = 1 # hwo much damage it does in a hit



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func deal_damage(reciever,  center_position: Vector2 = self.global_position):
	printerr('didnt configure fce for dealdmg', reciever, center_position )
