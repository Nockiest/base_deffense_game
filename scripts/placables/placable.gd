class_name Placable
extends Building

 
@export var placable_scene_to_load_path: String
@export var gold_cost:= 10

func _ready() -> void:
	if not can_afford_build:
		printerr('cant afford to build placable:', self)
	else:
		purchase()
	
	
func can_afford_build() -> bool:
	return Globals.gold >= gold_cost

func purchase():
	Globals.gold -= gold_cost
