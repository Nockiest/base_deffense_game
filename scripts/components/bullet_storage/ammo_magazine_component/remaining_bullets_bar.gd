class_name BulletBar
extends ProgressBar

@export var label:Label
func _ready() -> void:
	owner = $".."

func change_value(newVal:float) -> void:
	value = float(owner.current_ammo) / float(owner.capacity) * 100
	label.text = str(owner.current_ammo) + "/" + str(owner.capacity)
