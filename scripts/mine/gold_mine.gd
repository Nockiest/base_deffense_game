class_name GoldMine
extends Placable

@export var gold_per_click = 1

func provide_recource()->int:
	return gold_per_click
