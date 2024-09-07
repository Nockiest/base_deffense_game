class_name ExplodingMine
extends Placable

@export var area_of_effect_component: AreaOfEffectComponent
@export var single_damage_component: SingleDamageDealComponent
@export var target_groups: Array[String] = ['enemies']


# Called when the explosion animation finishes playing
func _on_explosion_finished(anim_name: String) -> void:
	if anim_name == "explosion":
		# Apply the effect after the animation finishes
		area_of_effect_component.apply_area_effect(single_damage_component.deal_damage , target_groups)
		var timer = get_tree().create_timer(2,  false)
		await timer.timeout
		queue_free()
	else:
		push_error('the explosion animation has a different name ', anim_name)


func _on_radius_area_entered(_node ) -> void:
	$Sprite2D/ExplosionAnimation.play("explosion")

func respond_to_click(_click_power:float):
	$Sprite2D/ExplosionAnimation.play("explosion")

 
