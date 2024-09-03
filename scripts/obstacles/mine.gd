class_name Mine
extends Area2D

@export var area_of_effect_component: AreaOfEffectComponent
@export var single_damage_component: SingleDamageDealComponent
@export var radius_visualizer: RadiusVisualizer
@export var target_groups: Array[String] = ['enemies']

func _ready():
	radius_visualizer.radius_px = area_of_effect_component.effect_radius_px

func _on_area_entered(_area: Area2D) -> void:
	$Sprite2D/ExplosionAnimation.play("explosion")
	radius_visualizer.start_display()

# Called when the explosion animation finishes playing
func _on_explosion_finished(anim_name: String) -> void:
	if anim_name == "explosion":
		# Apply the effect after the animation finishes
		area_of_effect_component.apply_area_effect(single_damage_component.deal_damage , target_groups)
		queue_free()
	else:
		printerr('the explosion animation has a different name ', anim_name)
