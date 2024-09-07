class_name Projectile
extends Node2D

@export var max_pierced_entities:= 1
@export var movement_component: MovementComponent 
@export var self_destruction_component: SelfDestructionComponent
@export var effects: Array[BaseEffect]
@export var range_px := 250 

@onready var valid_effects = effects.filter(func(effect):
		return effect != null and is_instance_valid(effect)
		)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectiles")
# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	if movement_component:
		movement_component.direction = new_direction.normalized()

func _on_area_entered(_area: Area2D) -> void:
	push_error('doesnt have on area entered')
	
func _process(_delta: float) -> void:
	if movement_component.distance_traveled > range_px :
		self_destruction_component.kill_owner()
	#print(area)
	#print_debug('ef1',area, effects)
	#var valid_effects = effects.filter(func(effect):
		#return effect != null and is_instance_valid(effect)
		#)
	##damage_deal_component.deal_damage(area, ['enemies', "turrets"])
	#for effect in valid_effects:
		#print_debug('ef',area, effect)
		#effect.apply_to_entity(area)
	#max_pierced_entities -= 1
	#if self_destruction_component == null:
		#push_error(self_destruction_component, ' is null')
		#return
	#if max_pierced_entities <= 0:
		#self_destruction_component.kill_owner()
