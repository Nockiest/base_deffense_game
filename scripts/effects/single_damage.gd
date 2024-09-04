class_name SingleDamage
extends BaseEffect 
## DEPRECATED use singledamagedealcomponent instead 

@export var damage:int= 1
@export var damage_modifier: float = 1
#effect_type = EffectTypes.EFFECT_TYPE.ONE_SHOT
# Called when the node enters the scene tree for the first time.
func _deal_damage(dmg:float= damage):
	if owner == null or !owner.has_method("take_hit"):
		oneErr.printerr_once("cant deal dmg to owner", ["cant deal dmg to owner", self, owner])
		return
	owner.take_hit(dmg)

func start_effect():
	_deal_damage( damage)

 
