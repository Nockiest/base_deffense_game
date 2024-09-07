extends CheckButton

 
	# Toggle the paused state of the game
	
# Consume left-click events to prevent them from affecting other inputs
# Connect the button's pressed signal in the editor or using code
func _ready():
	connect("pressed",  _on_pressed )


func _on_pressed() -> void:
	get_tree().paused = not get_tree().paused

	# Optional: Change the button text based on the paused state
	if get_tree().paused:
		text = "Resume"
	else:
		text = "Pause"
 
