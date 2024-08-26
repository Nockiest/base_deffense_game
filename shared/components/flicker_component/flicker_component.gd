class_name FlickerEffectComponent
extends Node

@export var flash_duration_sec: float = 1.0  # Duration of the flash effect in seconds
@export var flashing_color: Color = Color.WHITE  # Color to flash
var flicker_color_rect: ColorRect

# Original texture and modulate color of the parent Sprite2D
var original_texture: Texture2D
var original_modulate: Color

# Timer to handle the flash duration
@onready var flash_timer: Timer = $FlashTimer

func _ready() -> void:
 

	# Create and configure the ColorRect for flicker effect
	flicker_color_rect = ColorRect.new()
	flicker_color_rect.color = flashing_color
	flicker_color_rect.visible = false
	add_child(flicker_color_rect)

func start_flash(target: Node) -> void:
	if target is Sprite2D:
		# Store the original texture and modulate color
		original_texture = target.texture
		original_modulate = target.modulate
		
		# Set the texture to null and make the ColorRect visible
		target.texture = null
		flicker_color_rect.visible = true

		# Adjust the ColorRect size and position to match the Sprite2D
		flicker_color_rect.position = target.position
		flicker_color_rect.size = original_texture.get_size()
	elif target is ColorRect:
		# Store the original color
		original_modulate = target.color
		
		# Set the ColorRect's color to the flashing color
		target.color = flashing_color

	# Start the flash timer
	flash_timer.start()

func _on_flash_timeout() -> void:
	# Revert the target back to its original texture or color
	if flicker_color_rect.visible:
		var parent = flicker_color_rect.get_parent()
		if parent is Sprite2D:
			parent.texture = original_texture
		flicker_color_rect.visible = false
	elif flicker_color_rect.get_parent() is ColorRect:
		flicker_color_rect.get_parent().color = original_modulate

 
