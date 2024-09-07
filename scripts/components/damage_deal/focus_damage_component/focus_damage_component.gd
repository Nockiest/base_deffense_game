class_name FocusDamageDealComponent
extends DamageDealComponent

@export var damage_increase_rate: float = 2.0  # Rate at which damage increases over time


var focus_time: float = 0.0  # Initialize focus time
var damaged_entity: Node = null:
	set(value):  
		if value != damaged_entity:
			damaged_entity = value
			$state_machine.state.handle_entity_change(damaged_entity)

# Function to start focusing on an entity
var last_delta  
# Function to update focus time and apply damage to the focused entity
func _process(delta: float) -> void:
	last_delta = delta
	if damaged_entity:
		if    is_instance_valid(damaged_entity) :
			deal_damage(damaged_entity,   owner.global_position  )
# Update the focus time
func deal_damage(_reciever: Node,   _center_position: Vector2 = self.global_position) -> void:
	# Ensure the entity hasn't been queued for deletion
	if damaged_entity == null or damaged_entity.is_queued_for_deletion():
		push_error("Damaged entity is null or has been queued for deletion. Skipping damage.")
		return
	
	# Update focus time
	focus_time += last_delta

	# Calculate the increasing damage over time
	var total_damage = base_damage + (damage_increase_rate * focus_time)

	# Deal damage to the entity if it has a health component with a "take_hit" method
	if damaged_entity.health_component and damaged_entity.health_component.has_method("take_hit"):
		damaged_entity.health_component.take_hit(total_damage)
		print_debug("Dealing", total_damage, "damage to", damaged_entity)
	else:
		push_error("Damaged entity doesn't have 'take_hit' method or health_component. Skipping:", damaged_entity)
