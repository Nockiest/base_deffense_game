class_name CallWaveEarlyBtn
extends Button

# Define a custom signal to be emitted when the button is pressed
signal call_next_wave_early

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the button's "pressed" signal to the function that will handle it
	connect("pressed",  _on_button_pressed )

func _on_button_pressed() -> void:
	call_next_wave_early.emit()
	print("Call next wave early signal emitted!")
