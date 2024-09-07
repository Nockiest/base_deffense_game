class_name  FireEffect
extends  BaseEffect
 
@export var fire_damage_sec:= 1


 
func _deal_damage(dmg:float= fire_damage_sec):
	if owner == null or !owner.has_method("take_hit"):
		oneErr.print_once("cant deal dmg to owner",["cant deal dmg to owner", self, owner])
		return
	owner.take_hit(dmg)

func per_second_effect():
	_deal_damage(fire_damage_sec)
	
#func end_effect():

#func can_apply_on_entity(entity:Node)->bool:
	#if entity.effect_hold_component:
		#true
	#else:
		#printerr('cant apply effect to entity', entity)
		#false
