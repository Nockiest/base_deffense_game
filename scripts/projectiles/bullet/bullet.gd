extends Projectile
class_name Bullet

@export var movement_component: MomvementComponent 
@export var damage_deal_component: DamageDealComponent
@export var self_destruction_component: SelfDestructionComponent

@export var max_pierced_entities:= 1
 
# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	# Update the movement component's direction
	if movement_component:
		movement_component.direction = new_direction.normalized()

func _on_area_entered(area: Area2D) -> void:
	#print(area)
	damage_deal_component.deal_damage(area, ['enemies', "turrets"])
	max_pierced_entities -= 1
	if max_pierced_entities <= 0:
		self_destruction_component.kill_owner()
