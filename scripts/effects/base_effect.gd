class_name BaseEffect
extends NodeModClass

func get_type_name():
	return "BaseEffect"
 
@export var effect_type: EffectTypes.EFFECT_TYPE= EffectTypes.EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for per-second effect
@export var duration_sec: float = 5.0  # Total duration for the effect

@export var allowed_types: Array[String] = ['HealthComponent']  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  # Timer for per-second effects
var effect_timer: Timer = Timer.new()  # Timer for ON_AND_OFF effects
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize and configure the timer for on-and-off and per-second effects
	effect_timer.wait_time = duration_sec
	effect_timer.one_shot = true
	effect_timer.connect("timeout", cause_exit_effect,  )  # Corrected to connect to a specific function
	add_child(effect_timer)
	effect_timer.start()  # Add the timer to the scene tree first
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if effect_type == EffectTypes.EFFECT_TYPE.EFFECT_PER_SECOND:
		interval_timer += delta
		if interval_timer >= effect_interval:
			interval_timer = 0.0
			cause_per_second_effect(per_second_effect )
			
func start_effect():
	printerr('effect doesn\'t have a start function')

func cause_start_effect(start_fce: Callable = start_effect ) -> void:
	# If a callable is provided, call it; otherwise, use the default `start_effect`
	if start_fce != null and start_fce.is_valid():
		start_fce.call()
	else:
		start_effect()

func per_second_effect():
	printerr('effect doesn\'t do anything')

func cause_per_second_effect(per_sec_fce: Callable = per_second_effect ) -> void:
	if per_sec_fce != null and per_sec_fce.is_valid():
		per_sec_fce.call()
	else:
		per_second_effect()
		
func exit_effect():
	printerr('doesnt have exit effect')
	
func cause_exit_effect(callback: Callable = exit_effect  ) -> void:
	print('calling exit eff ', callback)
	# Check if a callable function is provided
	if callback != null and callback.is_valid():
		# Call the provided function
		callback.call()

	queue_free()

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
	#print ('1',entity, can_apply_on_node(entity))
	if can_apply_on_node(entity):
		# Add the effect to the EffectHoldComponent of the entity
		entity.get_node("EffectHoldComponent").add_effect(self.duplicate())
		# Iterate through the allowed types and apply the effect to matching nodes
	for type in allowed_types:
		#print_debug('2', type, entity.has_node(type))
		if entity.has_node(type):
			var entity_module = entity.get_node(type)
			#print_debug('3',entity_module, can_apply_on_node(entity_module))
			# Ensure the entity module is valid and has an EffectHoldComponent
			if can_apply_on_node(entity_module):
				# Create a copy of the current effect
				var effect_copy = self.duplicate()
				# Add the effect copy to the EffectHoldComponent of the entity module
				entity_module.get_node("EffectHoldComponent").add_effect(effect_copy)
				effect_copy.owner = entity_module
				effect_copy.cause_start_effect()
				
				if effect_type == EffectTypes.EFFECT_TYPE.ONE_SHOT:
					effect_copy.queue_free()
				# Start the effect if it's an ON_AND_OFF type
				if effect_type == EffectTypes.EFFECT_TYPE.ON_AND_OFF:
					effect_copy.effect_timer.start()

 
