class_name EffectHoldComponent
extends Node2D

## holds effects like fire damage effect, freeze etc.
#var effects:Array[Effect] = []

func add_effect(effect:Effect):
	add_child(effect)
