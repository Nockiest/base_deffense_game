extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_value(newVal:float) -> void:
	value = float(owner.current_ammo) / float(owner.capacity) * 100
	$Label.text = str(owner.current_ammo) + "/" + str(owner.capacity)
