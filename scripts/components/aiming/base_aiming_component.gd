# BaseAimingComponent.gd
class_name AimingComponent
extends Node2D

# The target position to aim at
var target_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_target_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_target_position()

# Function to be overridden by subclasses to update the target position
func update_target_position() -> void:
	pass
