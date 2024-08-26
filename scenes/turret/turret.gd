extends Node2D

class_name Turret

@export var aiming_component: AimingComponent
@export var ammo_magazine_component: AmmoMagazine
@export var bullet_scene: PackedScene  # Reference to the bullet scene
@export var reload_time: float 
@export var ammo_size: float 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if aiming_component:
		## Get the position of the turret
		#var turret_position = global_position
		## Get the position of the mouse from the AimingComponent
		#var mouse_position = aiming_component.mouse_position
		## Calculate the direction vector from the turret to the mouse
		#var direction = (mouse_position - turret_position).normalized()
		## Calculate the angle from the direction vector and set the rotation of the turret
		#rotation = direction.angle() + deg_to_rad(90)

# Called when the player clicks the turret.

 
