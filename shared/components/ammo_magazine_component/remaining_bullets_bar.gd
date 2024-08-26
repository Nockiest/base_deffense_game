extends ProgressBar

func _ready() -> void:
	owner = $".."

func change_value(newVal:float) -> void:
	value = float(owner.current_ammo) / float(owner.capacity) * 100
	$Label.text = str(owner.current_ammo) + "/" + str(owner.capacity)
