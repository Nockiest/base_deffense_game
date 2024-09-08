class_name GoldStorage
extends Component


@export var max_stored_gold := 50 
 
var stored_gold := 0 
 
func _ready() -> void:
	GoldManager.update_max_gold(  )
	
func cleanup_before_free() -> void:
	print("Cleaning up before freeing:", self)
	# Subtract the stored gold and max stored gold from the GoldManager
	self.remove_from_group('GoldStorers')
	GoldManager.update_max_gold( )
	#GoldManager.redistribute(-stored_gold, self)  

# Override the _exit_tree method to ensure cleanup occurs when the node is about to be freed
func _exit_tree() -> void:
	# Perform cleanup before the node is removed from the scene
	cleanup_before_free()
	
	
