class_name BaseEffect
extends NodeModClass

func get_type_name():
	return "BaseEffect"
 
@export var effect_type: EffectTypes.EFFECT_TYPE= EffectTypes.EFFECT_TYPE.ONE_SHOT
@export var effect_interval: float = 1.0  # Interval in seconds for per-second effect
@export var duration_sec: float = 5.0  # Total duration for the effect
@export var effect_timer: Timer  

@export var allowed_types: Array[String] = [ ]  # List of script class names this effect can be applied to

var elapsed_time: float = 0.0
var interval_timer: float = 0.0  
# Called when the node enters the scene tree for the first time.
 
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
		
func _on_effect_timer_end():
	print("timer ended")
	cause_exit_effect(exit_effect  ) 
func exit_effect():
	printerr('doesnt have exit effect')
	
func cause_exit_effect(callback: Callable = exit_effect  ) -> void:
	print('calling exit eff ', callback)
	# Check if a callable function is provided
	if callback != null and callback.is_valid():
		# Call the provided function
		callback.call()
	get_parent().remove_effect(self)

func can_apply_on_node(node: Node) -> bool:
	if node == null or !node.has_node("EffectHoldComponent"):
		printerr('Entity does not have EffectHoldComponent:', node)
		return false

	if node.has_method('get_type_name'):
		prints("x ", node.get_type_name() , node.get_type_name() in allowed_types)
		if node.get_type_name() in allowed_types:
			return true
	else:
		printerr(node, 'isn\'t inheriting from modclass')

	printerr('Cannot apply effect to node', node, node.get_class(), 'Allowed classes:', allowed_types)
	return false

func apply_to_entity(entity: Node) -> void:
	# Check if the entity is valid and has an EffectHoldComponent
	if can_apply_on_node(entity):
		create_copy(entity)
	print("allowed ", allowed_types)
	for type in allowed_types:
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
	effect_copy.cause_start_effect()
	if effect_copy.effect_timer == null:
		printerr("effect copy doesmt have an effect timer")
		return 
	if  effect_copy.effect_timer.wait_time!= 1:
		printerr("dont set effect timer duration directly in wait time it will be overriden")
	effect_copy.effect_timer.wait_time = duration_sec
	effect_copy.effect_timer.start()
	if not effect_copy.get_parent() is EffectHoldComponent:
		printerr("parent isnt effect hold comp, ", get_parent())
	if effect_type == EffectTypes.EFFECT_TYPE.ONE_SHOT:
		effect_copy.get_parent().remove_effect(self)
	print("added duplicate ", self.duplicate, " into ", entity_component)
		
func _on_timer_timeout() -> void:
	print('timer ended')
	cause_exit_effect( exit_effect  )
