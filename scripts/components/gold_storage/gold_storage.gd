class_name GoldStorage
extends Component


@export var max_stored_gold := 50:
	set(value):
		update_gold_manager_max_gold( value - max_stored_gold)
var stored_gold := 0 
	#set(value):
		#var accepted_value
		#if value > 0:
			#var max_insert_allowed = max_stored_gold - stored_gold
			#accepted_value = min(max_insert_allowed, value)
			#GoldManager.gold += accepted_value 
			#stored_gold += accepted_value
			#GoldManager.redistribute(value-accepted_value,self)
		#elif value < 0:
			#accepted_value = max(value, -stored_gold)
			#stored_gold -= accepted_value 
			#GoldManager.gold -= accepted_value 
			#GoldManager.redistribute(value+accepted_value,self)
		#print_rich('[b]accepted[/b]', accepted_value)

func _ready() -> void:
	update_gold_manager_max_gold(max_stored_gold)
	
func update_gold_manager_max_gold(ammount:int):
	GoldManager.update_max_gold(ammount )


func cleanup_before_free() -> void:
	print("Cleaning up before freeing:", self)
	# Subtract the stored gold and max stored gold from the GoldManager
	GoldManager.update_max_gold(-max_stored_gold)
	#GoldManager.redistribute(-stored_gold, self)  

# Override the _exit_tree method to ensure cleanup occurs when the node is about to be freed
func _exit_tree() -> void:
	# Perform cleanup before the node is removed from the scene
	cleanup_before_free()
	
	
