extends DamageDealComponent


var focus_time: float = 0.0  # Initialize focus time


# Function to deal damage, making it stronger with focus time
func deal_damage(reciever: Node, damagable_object_groups: Array[String], center_position: Vector2 = self.global_position) -> void:
	# Check if the reciever is in one of the specified damageable groups
	for group_name in damagable_object_groups:
		if reciever.is_in_group(group_name):
			# Calculate the total damage based on focus time
			var total_damage = base_damage * (1.0 + focus_time)
			
			# Check if the reciever has a health component and a method to take damage
			if reciever.has_method("take_hit"):
				reciever.take_hit(int(total_damage))  # Apply the damage
			else:
				printerr("Receiver doesn't have 'take_hit' method. Skipping:", reciever)
			return  # Exit after dealing damage to the valid receiver

	print("Receiver is not in any of the specified damageable groups:", reciever)
