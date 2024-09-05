extends Node

var game_lost := false:
	set(value):
		if value == true:
			print('game lost chaning to end game screen')

@export var gold:int = 0:
	set(value):
		if value <= 0:
			printerr('attempting to set gold bellow 0:', value)
		gold = max(0, value)
		print( 'gold changed to value:', gold)
