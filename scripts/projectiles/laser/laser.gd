class_name Laser
extends Projectile

@export var damage_deal_component: FocusDamageDealComponent
		
@onready var raycast: RayCast2D = $"." 
	 
func _process(_delta: float) -> void:
	give_dmg_comp_entity_to_dmg()
func give_dmg_comp_entity_to_dmg():
	var new_entity = null
	if  raycast.enabled:
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target and damage_deal_component:
				new_entity= target
	  
	damage_deal_component.damaged_entity = new_entity
				#damage_deal_component.deal_damage(target, ['enemies'])  # Pass an empty group list if not needed

func set_direction(new_direction: Vector2) -> void:
	if raycast:
		raycast.target_position = new_direction * range_px
		print("RayCast2D target position set to:", raycast.target_position)
	else:
		print("RayCast2D node not found")

# Method to activate the laser
func toggle_active() -> void:
	raycast.enabled = not raycast.enabled
	#damage_deal_component.toggle_focus()
	#print("Laser active?", raycast.enabled)

 
