extends State



func enter(msg:={} ):
	print('msg',msg)
 
	
func _on_node_clicked(node: Node) -> void:
	pass
	#if not node:
		## Instantiate the building from the selectedBuilding PackedScene
		#var new_building = selectedBuilding.instantiate()
		## Set the global position of the new building to the mouse position
		#new_building.global_position = owner.get_global_mouse_position()
		#if can_place_node(new_building):
			#Utils.add_child_to_battleground(new_building, 'Buildings')
			#building_to_place_changed.emit()
			##selectedBuilding = null
			#state_machine.transition_to('Basic')
		#else:
			#printerr("Cannot place the building here. Overlap detected.")
	
func  on_construction_bar_clicked(node_packed: PackedScene) :
	#print(selectedBuilding ==node_packed)
	owner.building_to_place_changed.emit(node_packed)
	#if selectedBuilding ==node_packed:
		#state_machine.transition_to('Basic')
		
# Function to switch to the Building state
#func can_place_node(node: Node) -> bool:
	## Ensure the node has a CollisionShape2D
	#if not node:
		#return false
#
	## Iterate through all CollisionShape2D nodes in the scene
	#for child in get_tree().get_nodes_in_group("BattlegroundObjects"):
		#if child.get_node('CollisionShape2D') is CollisionShape2D:
			## Check for collision
			#if is_shape_overlapping(node.get_node('CollisionShape2D'), child.get_node('CollisionShape2D')):
				#return false
	#
	#return true

#func is_shape_overlapping(colShape1: CollisionShape2D, colShape2: CollisionShape2D) -> bool:
	#if not (colShape1 is CollisionShape2D and colShape2 is CollisionShape2D):
		#return false
	#
	#var shape1 = colShape1.shape
	#var shape2 = colShape2.shape
#
	#if shape1 and shape2:
		#var space_state = owner.get_world_2d().direct_space_state
		#var query = PhysicsShapeQueryParameters2D.new()
		#query.shape = shape2
		#query.transform = colShape2.global_transform
		#query.collide_with_areas = true
		#query.collide_with_bodies = true
		#
		#var results = space_state.intersect_shape(query)
		#for result in results:
			#if result.collider == colShape1:
				#return true
	#
	#return false


func _on_item_placer_placable_instance_changed(placable_instance: Placable) -> void:
	if not placable_instance and state_machine.state == self:
		state_machine.transition_to('Basic')
