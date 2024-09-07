class_name AutoShootComponent
extends Component


@export var aiming_component:AimingComponent 
@export var magazine_component: ProjectileStorage  

var enabled := true

func _process(_delta: float) -> void:
	if enabled and aiming_component.target_position:
		magazine_component.fire_bullet(owner.rotation)
