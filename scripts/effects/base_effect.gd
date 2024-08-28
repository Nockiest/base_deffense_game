class_name BaseEffect
extends Node

 
@export var effect_type: EffectTypes.EFFECT_TYPE= EffectTypes.EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for per-second effect
@export var duration: float = 5.0  # Total duration for the effect

@export var allowed_types: Array[String] = ['HealthComponent']  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  # Timer for per-second effects
var effect_timer: Timer = Timer.new()  # Timer for ON_AND_OFF effects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if effect_type == EffectTypes.EFFECT_TYPE.ON_AND_OFF:
		effect_timer.wait_time = duration
		effect_timer.one_shot = true
		effect_timer.connect("timeout",  _on_effect_timeout )
		add_child(effect_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if effect_type == EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND:
		interval_timer += delta
		if interval_timer >= effect_interval:
			interval_timer = 0.0
			cause_per_second_effect()

func cause_start_effect() -> void:
	printerr('effect doesn\'t have a start function')

func cause_per_second_effect() -> void:
	printerr('effect doesn\'t do anything')

func cause_exit_effect() -> void:
	printerr('effect doesn\'t have an end function')

func _on_effect_timeout() -> void:
	cause_exit_effect()
	queue_free()  # Remove the effect after it ends

func can_apply_on_node(node: Node) -> bool:
	if !node.has_node("EffectHoldComponent"):
		printerr('Entity does not have EffectHoldComponent:', node)
		return false

	if node.has_method('get_type_name'):
		if node.get_type_name() in allowed_types:
			return true
	else:
		printerr(node, 'isn\'t inheriting from modclass')

	printerr('Cannot apply effect to node', node, node.get_class(), 'Allowed classes:', allowed_types)
	return false

func apply_to_entity(entity: Node) -> void:
	# Check if the entity is valid and has an EffectHoldComponent
	print ('1',entity, can_apply_on_node(entity))
	if can_apply_on_node(entity):
		# Add the effect to the EffectHoldComponent of the entity
		entity.get_node("EffectHoldComponent").add_effect(self.duplicate())
		
		# Iterate through the allowed types and apply the effect to matching nodes
	for type in allowed_types:
		print_debug('2', type, entity.has_node(type))
		if entity.has_node(type):
			var entity_module = entity.get_node(type)
			print_debug('3',entity_module, can_apply_on_node(entity_module))
			# Ensure the entity module is valid and has an EffectHoldComponent
			if can_apply_on_node(entity_module):
				# Create a copy of the current effect
				var effect_copy = self.duplicate()
				# Add the effect copy to the EffectHoldComponent of the entity module
				entity_module.get_node("EffectHoldComponent").add_effect(effect_copy)
				effect_copy.owner = entity_module
				effect_copy.cause_start_effect()
				# Start the effect if it's an ON_AND_OFF type
				if effect_type == EffectTypes.EFFECT_TYPE.ON_AND_OFF:
					effect_copy.effect_timer.start()

 
