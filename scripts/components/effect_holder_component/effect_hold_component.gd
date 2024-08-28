class_name EffectHoldComponent
extends Node2D

## holds effects like fire damage effect, freeze etc.


func add_effect(effect:BaseEffect):
	add_child(effect)
