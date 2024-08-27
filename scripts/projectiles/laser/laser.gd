class_name Laser
extends Projectile

@export var damage_deal_component: DamageDealComponent
@export var range_px: int = 100:
	set(value):
		range_px = value
		#raycast = $RayCast2D
		#raycast.target_position = Vector2(0,0) * range_px
		
@onready var raycast: RayCast2D = $RayCast2D 
	

func _ready() -> void:
	raycast = $RayCast2D
	if raycast:
		raycast.enabled = false  # Initially disable the RayCast2D
	else:
		printerr("RayCast2D node not found")

func _process(_delta: float) -> void:
	if raycast and raycast.enabled:
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target and damage_deal_component:
				damage_deal_component.deal_damage(target, ['enemies'])  # Pass an empty group list if not needed

func set_direction(new_direction: Vector2) -> void:
	raycast = $RayCast2D
	if raycast:
		# Update the RayCast2D's direction and range
		raycast.target_position = new_direction * range_px
		print("RayCast2D target position set to:", raycast.target_position)
	else:
		print("RayCast2D node not found")

# Method to activate the laser
func toggle_active() -> void:
	if raycast:
		raycast.enabled = not raycast.enabled
		print("Laser active?", raycast.enabled)

 
