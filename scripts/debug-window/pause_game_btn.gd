extends CheckButton

# This function toggles the game's paused state
func _on_PauseButton_pressed():
	# Toggle the paused state of the game
	get_tree().paused = not get_tree().paused

	# Optional: Change the button text based on the paused state
	if get_tree().paused:
		text = "Resume"
	else:
		text = "Pause"

# Connect the button's pressed signal in the editor or using code
func _ready():
	connect("pressed", _on_PauseButton_pressed )
