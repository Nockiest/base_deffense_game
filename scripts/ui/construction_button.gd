class_name ConstructionButton
extends Button

@export var constructed_entity:PackedScene
signal pressedConstructionButton(constructed_entity:PackedScene)
# Called when the node enters the scene tree for the first time
func _ready() -> void:
	add_to_group("ConstructionButtons")
	connect("pressed", _on_button_pressed )

# Function to handle turret button press
func _on_button_pressed() -> void:
	pressedConstructionButton.emit(constructed_entity)
 
