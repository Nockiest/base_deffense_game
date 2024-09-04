extends Node2D
class_name Component

@export var effect_hold_component:EffectHoldComponent

func update_modifier(_modifier  ,_new_value:float ):
	printerr('havent written a fce to update modifier', self)
	pass

func _ready() -> void:
	if !effect_hold_component:
		printerr("effect hold comp not set ", self, " ", owner)
