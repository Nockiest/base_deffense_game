extends Area2D
## TO DO thing about how to make differnt types of bullets
class_name Bullet

@export var movement_component: MomvementComponent 
@export var damage_deal_component: DamageDealComponent
@export var self_destruction_component: SelfDestructionComponent
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectiles")
# Set the direction for the bullet and immediately update its velocity
func set_direction(new_direction: Vector2) -> void:
	# Update the movement component's direction
	if movement_component:
		movement_component.direction = new_direction.normalized()

func _on_area_entered(area: Area2D) -> void:
	print(area)
	damage_deal_component.deal_damage(area, ['enemies'])
	#if (area.health_component):
		#area.health_component.take_hit(damage_deal_component.base_damage)
		#queue_free()
	self_destruction_component.kill_owner()
