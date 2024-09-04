extends Control

# Load the packed scenes for turret and mine
@export var turret_scene: PackedScene
@export var mine_scene: PackedScene

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Connect button signals
	$TurretButton.connect("pressed", _on_turret_button_pressed )
	$GoldMineButton.connect("pressed",  _on_mine_button_pressed )

# Function to handle turret button press
func _on_turret_button_pressed() -> void:
	print("Turret Scene:", turret_scene)
	
# Function to handle mine button press
func _on_mine_button_pressed() -> void:
	print("Mine Scene:", mine_scene)
