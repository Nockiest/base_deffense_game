class_name GoldMine
extends Placable

@export var gold_per_click = 1
 
func provide_recource()->int:
	return gold_per_click


func respond_to_click(click_power):
	Globals.gold += click_power * provide_recource()
