extends CanvasLayer

func _ready() -> void:
	set_labels_to_black(self)

func set_labels_to_black(node):
	# Check if the node is a Label
	if node is Label:
		node.modulate = Color("black") # Set the label's color to black

	# Recursively call this function for all children of the node
	for child in node.get_children():
		set_labels_to_black(child)

func _process(_delta: float) -> void:
	$VBoxContainer/MousePosition.text = 'X:' + str( get_parent().get_global_mouse_position().x ) + ' Y:' + str(  get_parent().get_global_mouse_position().y ) 
	$VBoxContainer/PlayerState.text = 'Player State:' + str($"../Player/StateMachine".state )
	$VBoxContainer/TreasuryState.text = 'Gold: ' + str(Globals.gold)
