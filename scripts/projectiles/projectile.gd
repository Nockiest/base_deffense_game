class_name Projectile
extends Node2D

 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectiles")
# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	printerr("dont have fce for setting direction in this comp", owner)
	# Update the movement component's direction
	#if movement_component:
		#movement_component.direction = new_direction.normalized()

func _on_area_entered(area: Area2D) -> void:
	printerr("dindt set on area enetered fce for projectile", owner)
	#print(area)
	#damage_deal_component.deal_damage(area, ['enemies', "turrets"])
	##if (area.health_component):
		##area.health_component.take_hit(damage_deal_component.base_damage)
		##queue_free()
	#self_destruction_component.kill_owner()
