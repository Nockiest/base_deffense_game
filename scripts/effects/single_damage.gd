class_name SingleDamage
extends BaseEffect 
func get_type_name():
	return "SingleDamage"
@export var damage:int= 1
#effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT
# Called when the node enters the scene tree for the first time.
func _deal_damage(dmg:float= damage):
	if owner == null or !owner.has_method("take_hit"):
		printerr("cant deal dmg to owner", self, owner)
		return
	owner.take_hit(dmg)

func cause_start_effect() -> void:
	print_debug('cause start effect ', owner)
	_deal_damage()
