class_name EffectHoldComponent
extends Component

# Holds effects like fire damage, freeze, etc.
#@export var effect_variable_names:Array[String] = ['speed_modifier_change']
# Adds an effect to the component as a child node
func add_effect(effect: BaseEffect, variable_to_update:String='') -> void:
	if effect and effect not in get_children():
		add_child(effect)
		print("Effect added:", owner, effect.name)
	else:
		oneErr.printerr_once('invalid effect', ["Effect already exists or is invalid:", effect, owner])
	if variable_to_update != '':
		cause_update(variable_to_update)
	else:
		cause_update(variable_to_update)
# Removes an effect from the component
func remove_effect(effect: BaseEffect,variable_to_update:String='') -> void:
	if effect in get_children():
		remove_child(effect)
		print("Effect removed:", effect.name)
	else:
		oneErr.printerr_once( 'effect holder without effect',["Effect holder doesn't have the effect:", effect, owner])
	if variable_to_update != '':
		cause_update(variable_to_update)
	else:
		printerr(variable_to_update, ' variable to update not defined')

func cause_update(variable_to_update):
 
	if not owner is Component or not variable_to_update in owner:
		printerr('Owner does not have the variable:', variable_to_update, owner)
		return
		# Get the value of the owner's base variable

	## get a dictionary of modifiers, that are applied by the children
	var unique_modifiers:Dictionary =   parse_effect_modifiers_from_children(self,variable_to_update )
	# Calculate the total modifier percentage	
	var modifier_value =  calculate_modifier_from_dict(unique_modifiers) 
	owner.update_modifier( variable_to_update,modifier_value)

func calculate_modifier_from_dict(dictionary:Dictionary ) -> float:
	var current_modifier = 1
	# Apply only unique modifiers once
	for modifier in dictionary.values():
		print_debug(modifier)
		current_modifier += modifier
	return current_modifier

func parse_effect_modifiers_from_children(node: EffectHoldComponent, value_property: String,allow_duplicates: bool = false) -> Dictionary:
	var unique_modifiers: Dictionary = {}
	var modifier_counts: Dictionary = {}  # To track counts of each modifier type
	for child in node.get_children():
		if not value_property in child:
			printerr(child, " doesn't contain the property ", value_property, ", occurred in ", owner)
			continue
		
		if not child.modulated_modifier:
			printerr(child, " doesn't contain an effect name, occurred in ", owner)
			continue
		
		var modulated_modifier = child.modulated_modifier  # Assuming unique modifier types are identified by name
		var new_value = child.get(value_property)  # Use get() to retrieve the value dynamically
		# Check if the modifier type already exists in the dictionary
		if allow_duplicates:
			# Handle duplicates by appending a numeric suffix
			if modifier_counts.has(modulated_modifier):
				modifier_counts[modulated_modifier] += 1
			else:
				modifier_counts[modulated_modifier] = 1
			
			var unique_key = modulated_modifier + str(modifier_counts[modulated_modifier])
			unique_modifiers[unique_key] = new_value
		else:
			# Handle without duplicates, updating only if the new value is higher
			if unique_modifiers.has(modulated_modifier):
				if unique_modifiers[modulated_modifier] < new_value:
					unique_modifiers[modulated_modifier] = new_value
			else:
				unique_modifiers[modulated_modifier] = new_value
			
	return unique_modifiers
