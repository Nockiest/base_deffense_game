class_name BaseEffect
extends Node2D
 
@export var effect_name:String
@export var effect_type: EffectTypes.EFFECT_TYPE= EffectTypes.EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for per-second effect
@export var duration_sec: float = 5.0  # Total duration for the effect
@export var effect_timer: Timer  

@export var applicable_components: Array[String] = [ ]  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  
# Called when the node enters the scene tree for the first time.
			
func start_effect():
	printerr('effect doesn\'t have a start function')

func per_second_effect():
	printerr('effect doesn\'t do anything')

func exit_effect():
	printerr('doesnt have exit effect')

func can_apply_on_node(node: Node) -> bool:
	if node == null or !node.has_node("EffectHoldComponent"):
		printerr('Entity does not have EffectHoldComponent:', node)
		return false

	if node.name:
		prints("x ", node.name , node.name in applicable_components)
		if node.name in applicable_components:
			return true
	else:
		printerr(node, 'isn\'t inheriting from modclass')

	printerr('Cannot apply effect to node', node, node.get_class(), 'Allowed classes:', applicable_components)
	return false

func apply_to_entity(entity: Node) -> void:
	# Check if the entity is valid and has an EffectHoldComponent
	if can_apply_on_node(entity):
		create_copy(entity)
	print("allowed ", applicable_components)
	for type in applicable_components:
		print( "entiity has?", type, entity.has_node(type))
		if entity.has_node(type):
			var entity_component = entity.get_node(type)  
			if not entity_component is Component:
				printerr("Failed to cast node to Component:", entity_component)
			# Ensure the entity module is valid and has an EffectHoldComponent
			prints( entity, type, entity_component )
			if can_apply_on_node(entity_component):
				# Create a copy of the current effect
				create_copy(entity_component)

func create_copy(entity_component:Component):
	var effect_copy = self.duplicate()
	if not entity_component.effect_hold_component:
		printerr('entity doesnt have effect hold comp ', entity_component)
	entity_component.effect_hold_component.add_effect(effect_copy)
	effect_copy.owner = entity_component
	effect_copy.get_node('StateMachine').transition_to('Start')
	if not effect_copy.get_parent() is EffectHoldComponent:
		printerr("parent isnt effect hold comp, ", get_parent())
	print("added duplicate ", self.duplicate, " into ", entity_component)
		
