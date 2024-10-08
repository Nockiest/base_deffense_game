class_name BaseEffect
extends Node2D
## Holds and rewuests value updates for a component it resides in 

@export var modulated_modifier:String ## name of the modifier it changes
@export var effect_name:String  ## to avoid duplication of some effects
@export var effect_type: EffectTypes.EFFECT_TYPE = EffectTypes.EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for per-second effect
@export var duration_sec: float = 5.0  # Total duration for non one time the effect
@export var effect_timer: Timer  
@export var applicable_components: Array[String] = [ ]  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  
# Called when the node enters the scene tree for the first time.
			
func start_effect():
	push_error('effect doesn\'t have a start function')

func per_second_effect():
	push_error('effect doesn\'t do anything')

func exit_effect():
	push_error('doesnt have exit effect')

func can_apply_on_node(node: Node) -> bool:
	if node == null or !node.has_node("EffectHoldComponent"):
		push_error('Entity does not have EffectHoldComponent:', node)
		return false

	if node.name:
		prints("x ", node.name , node.name in applicable_components)
		if node.name in applicable_components:
			return true
	else:
		push_error(node, 'isn\'t inheriting from modclass')

	push_error('Cannot apply effect to node', node, node.get_class(), 'Allowed classes:', applicable_components)
	return false

func apply_to_entity(entity: Node) -> void:
	# Check if the entity is valid and has an EffectHoldComponent
	if can_apply_on_node(entity):
		create_copy(entity)
	for type in applicable_components:
		if entity.has_node(type):
			var entity_component = entity.get_node(type)  
			if not entity_component is Component:
				push_error("Failed to cast node to Component:", entity_component)
			# Ensure the entity module is valid and has an EffectHoldComponent
			prints( entity, type, entity_component )
			if can_apply_on_node(entity_component):
				# Create a copy of the current effect
				create_copy(entity_component)

func create_copy(entity_component:Component):
	var effect_copy = self.duplicate()
	if not entity_component.effect_hold_component:
		push_error('entity doesnt have effect hold comp ', entity_component)
	entity_component.effect_hold_component.add_effect(effect_copy,modulated_modifier)
	effect_copy.owner = entity_component
	effect_copy.get_node('StateMachine').transition_to('Start')
	if not effect_copy.get_parent() is EffectHoldComponent:
		push_error("parent isnt effect hold comp, ", get_parent())
		
func _ready():
	if not owner is EffectHoldComponent:
		push_error('owner isnt effect hold comp ', owner)
 
