class_name ObjectContainerManager extends Component

 
@export var entity_container: ObjectContainer 
 

# Function to receive a node and send it to the appropriate container
func add_child_node(node: Node) -> void:
	pass
	#if node is Entity :
		#entity_container.recieve_child_node(node)
#    elif node is Structure:
#        structure_container.recieve_child_node(node)
	#elif node is Projectile:
		#projectile_container.recieve_child_node(node)
	#else:
		#print_debug("Unknown node type")

# Function to retrieve an object from the appropriate container
func retrieve_object(container_type: String, object_name: String) -> Node:
	var container: ObjectContainer = select_container_from_string(container_type)
	# Retrieve the object from the container based on the name
	return container.retrieve_child_node_by_name(object_name)
	
func is_container_full(container_type: String) -> bool:
	var container: ObjectContainer = select_container_from_string(container_type)
	# Check if the container is empty
	return container.is_full()
	
func select_container_from_string(word:String) -> ObjectContainer:
	return entity_container
	#match word:
		#"Entity":
			#return entity_container
		#"Structure":
			#printerr("Currently not supporting structures")
			#return structure_container
		#"Projectile":
			#return projectile_container
		#_:
			#printerr("Unknown container type")
			#return entity_container
