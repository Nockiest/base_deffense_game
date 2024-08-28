class_name  BaseEffect
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cause_effect():
	printerr('effect doesnt do anything')
	
func end_effect():
	printerr('effect doesnt have an end')

func can_apply_on_entity(entity:Node) :
	if entity.effect_hold_component:
		true
	else:
		printerr('cant apply effect to entity', entity)
		false




func apply_to_entity(entity:Node):
	if can_apply_on_entity(entity ):
		entity.effect_hold_component.add_effect(self)
