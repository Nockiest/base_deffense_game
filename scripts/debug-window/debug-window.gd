extends CanvasLayer

# Dictionary to hold debug values and corresponding label paths
var debug_values = {
	"Mouse Position": "",
	"Player State": "",
	"Treasury State": "",
	"FPS": "",
	"Turret Enabled": "",
	'Turret_target': null,
	
}

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	set_labels_to_black(self)
	create_debug_labels()

# Set all label colors to black
func set_labels_to_black(node):
	if node is Label:
		node.modulate = Color("black")  # Set the label's color to black

	# Recursively call this function for all children of the node
	for child in node.get_children():
		set_labels_to_black(child)

# Create labels for each debug value
func create_debug_labels():
	var vbox_container = $VBoxContainer
	
	for key in debug_values.keys():
		# Create a new label for each debug value
		var label = Label.new()
		label.name = key
		label.text = key + ": "  # Initial text
		vbox_container.add_child(label)

# Update the debug values and labels every frame
func _process(_delta: float) -> void:
	# Update the values in the dictionary
	debug_values["Mouse Position"] = 'X:' + str(get_parent().get_global_mouse_position().x) + ' Y:' + str(get_parent().get_global_mouse_position().y)
	debug_values["Player State"] = 'Player State: ' + str($"../Player/StateMachine".state)
	debug_values["Treasury State"] = 'Gold: ' + str(GoldManager.gold) + '/' + str(GoldManager.max_gold)
	debug_values["FPS"] = 'FPS: ' + str(Engine.get_frames_per_second())
	var turret = get_tree().get_first_node_in_group('turrets')
	if not  (turret == null):
		debug_values["Turret Enabled"] = 'Turret Enabled: ' + str(get_tree().get_first_node_in_group('turrets').get_node('TurretCannon').auto_shoot_component.enabled)
		debug_values['Turret_target'] = 'Turret_target' + str(get_tree().get_first_node_in_group('turrets').get_node('TurretCannon').aiming_component.current_target)
		debug_values['Turret_State'] = 'Turret_state' + str(get_tree().get_first_node_in_group('turrets').get_node('TurretCannon').get_node('StateMachine').state)
	# Update the corresponding labels with the current values
	for key in debug_values.keys():
		var label = $VBoxContainer.get_node_or_null(key)
		if label:
			label.text = key + ": " + debug_values[key]
		else:
			label = Label.new()
			label.name = key
			$VBoxContainer.add_child(label)
			
