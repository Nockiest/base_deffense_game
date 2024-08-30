class_name ObjectContainer 
extends Component 

signal objects_changed(objects)

@export var max_objects: int = 1
@export var allowed_object_type: String = "Entity"  # Adjust this to the desired type

# Function to add a child node
func recieve_child_node(child_node:Node):
	var is_valid_type = child_node.is_class(allowed_object_type)
	var is_within_limit = get_child_count() < max_objects

	oneErr.printerr_once([
		"Type mismatch:", not is_valid_type,
		"Maximum objects reached:", not is_within_limit,
#		"Child type:",  child_node.get_type(),
		"Allowed type:", allowed_object_type
	], true)

	if  is_valid_type and !is_full() :#is_within_limit and is_valid_type
		add_child(child_node)
		emit_signal("objects_changed", get_children())
	else:
		oneErr.printerr_once(["Cannot add child node: Type mismatch or maximum number of objects reached", get_children()], true)

func is_full() -> bool:
	return get_child_count() >= max_objects
# Function to remove a child node
func remove_child_node(child_node):
	if child_node in get_children():
		remove_child(child_node)
		emit_signal("objects_changed", get_children())
		return child_node
	else:
		print_debug("Child node not found")
