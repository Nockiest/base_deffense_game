class_name AutoShootComponent
extends Component


@export var aiming_component:AimingComponent 
@export var magazine_component: ProjectileStorage  
@onready var shoot_timer: Timer = $Timer

var enabled := true:
	set(value):
		enabled = not enabled
		
		if enabled:
			_start_auto_shooting()
		else:
			_stop_auto_shooting()

func _ready() -> void:
	if enabled:
		_start_auto_shooting()

#func _process(_delta: float) -> void:
	#if enabled and aiming_component.target_position:
		#magazine_component.fire_bullet(owner.rotation)


func _on_timer_timeout() -> void:
	if enabled and magazine_component != null and magazine_component.has_method("fire_bullet"):
		magazine_component.fire_bullet(owner.rotation)
		
func _start_auto_shooting() -> void:
	if shoot_timer:
		shoot_timer.wait_time = magazine_component.shoot_interval_sec  # Update timer wait time
		shoot_timer.start()  # Start the timer

# Function to stop the auto-shooting process
func _stop_auto_shooting() -> void:
	if shoot_timer:
		shoot_timer.stop()
