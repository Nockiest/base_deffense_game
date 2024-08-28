class_name  FireEffect
extends  BaseEffect
func get_type_name():
	return "FireEffect"
 
@export var fire_damage_sec:= 1
@export var effect_duration_sec:= 3

 
func _deal_damage(dmg:float= fire_damage_sec):
	if owner == null or !owner.has_method("take_hit"):
		printerr("cant deal dmg to owner", self, owner)
		return
	owner.take_hit(dmg)

func cause_per_second_effect():
	_deal_damage()
	
#func end_effect():

#func can_apply_on_entity(entity:Node)->bool:
	#if entity.effect_hold_component:
		#true
	#else:
		#printerr('cant apply effect to entity', entity)
		#false
