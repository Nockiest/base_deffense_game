class_name  FireEffect
extends  BaseEffect
 
@export var fire_damage_sec:= 1
@export var effect_duration_sec:= 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cause_effect():
	if owner.health_component:
		owner.health_component.take_hit()

	
#func end_effect():

#func can_apply_on_entity(entity:Node)->bool:
	#if entity.effect_hold_component:
		#true
	#else:
		#printerr('cant apply effect to entity', entity)
		#false
