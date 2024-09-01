extends Node2D
class_name Component

@export var effect_hold_component:EffectHoldComponent

func update_modifier():
	printerr('havent written a fce to update modifier')
	pass

func _ready() -> void:
	if !effect_hold_component:
		printerr("effect hold comp not set ", self, " ", owner)
	update_modifier()  # Initialize the speed based on current modifiers
