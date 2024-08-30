class_name GoldMine
extends NodeModClass

@export var gold_per_click = 1

func get_type_name():
	return "Mine"


func provide_recource()->int:
	return gold_per_click

func _input(input:InputEvent)->void:
	pass
