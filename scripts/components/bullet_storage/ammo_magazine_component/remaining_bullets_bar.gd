class_name BulletBar
extends ProgressBar

@export var label:Label
func _ready() -> void:
	owner = $".."

func change_value(newVal:float, capacity:float) -> void:
	value = float(newVal) / float( capacity) * 100
	label.text = str(newVal) + "/" + str(capacity)
