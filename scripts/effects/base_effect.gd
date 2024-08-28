class_name BaseEffect
extends Node

enum EFFECT_TYPE {
	ONE_SHOT,
	EFFECT_PER_SECOND,
	ON_AND_OFF
}

@export var effect_type: EFFECT_TYPE = EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for the per-second effect
@export var duration: float = 5.0  # Total duration for the effect

@export var allowed_types: Array[String] = [  'HealthComponent' ]  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  # Timer for per-second effects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cause_start_effect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta

	match effect_type:
		EFFECT_TYPE.ONE_SHOT:
			# One-shot effects should only trigger once at the start
			queue_free()  # Remove effect after triggering
		EFFECT_TYPE.EFFECT_PER_SECOND:
			# Trigger per-second effects based on interval
			interval_timer += delta
			if interval_timer >= effect_interval:
				interval_timer = 0.0
				cause_per_second_effect()
		EFFECT_TYPE.ON_AND_OFF:
			# Process duration and exit effect
			if elapsed_time >= duration:
				cause_exit_effect()
				queue_free()  # Remove the effect after it ends

func cause_start_effect() -> void:
	printerr('effect doesnt have a start fce')

func cause_per_second_effect() -> void:
	printerr('effect doesnt do anything')

func cause_exit_effect() -> void:
	printerr('effect doesnt have an end')

func can_apply_on_entity(entity: Node) -> bool:
	if !entity.has_node("EffectHoldComponent"):
		printerr('Entity does not have effect_hold_component:', entity)
		return false
	#for allowed in allowed_types:
	if entity.has_method('get_type_name'):
		if entity.get_type_name( ) in allowed_types   :
			return true
	else:
		printerr(entity, ' isnt inhereting from modclass')
		 
	printerr('Cannot apply effect to entity', entity, entity.get_class(), 'Allowed classes:', allowed_types)
	return false
	 

func apply_to_entity(entity: Node) -> void:
	if can_apply_on_entity(entity):
		entity.get_node("EffectHoldComponent").add_effect(self)
