class_name Treasury
extends Node2D

@export var gold:int = 0:
	set(value):
		if value <= 0:
			push_error('attempting to set gold bellow 0:', value)
		gold = max(0, value)
		print( 'gold changed to value:', gold)
#@export var science:int = 0

 
func _ready():
	var num_tresuries = get_tree().get_nodes_in_group('treasury')
	if len(num_tresuries) != 1:
		push_error('num treasuries is not 1:', num_tresuries)
	
