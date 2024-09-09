class_name UpgraderComponent
extends Component


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpgradeManager.apply_upgrades(owner)
