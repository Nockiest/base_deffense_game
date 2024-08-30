class_name Mine
extends AreaModClass

@export var area_of_effect_component: AreaOfEffectComponent
@export var single_damage_component: SingleDamage
@export var target_groups: Array[String] = ['enemies']

func get_type_name():
	return 'Mine'


func _on_area_entered(area: Area2D) -> void:
	$Sprite2D/ExplosionAnimation.play("explosion")

# Called when the explosion animation finishes playing
func _on_explosion_finished(anim_name: String) -> void:
	if anim_name == "explosion":
		# Apply the effect after the animation finishes
		area_of_effect_component.apply_area_effect(single_damage_component.apply_to_entity, target_groups)
		queue_free()
	else:
		printerr('the explosion animation has a different name ', anim_name)
