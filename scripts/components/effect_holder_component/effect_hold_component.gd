class_name EffectHoldComponent
extends Component

# Holds effects like fire damage, freeze, etc.
#@export var effect_variable_names:Array[String] = ['speed_modifier_change']
# Adds an effect to the component as a child node
func add_effect(effect: BaseEffect, variable_to_update:String) -> void:
	if effect and effect not in get_children():
		add_child(effect)
		print("Effect added:", owner, effect.name)
	else:
		oneErr.printerr_once('invalid effect', ["Effect already exists or is invalid:", effect, owner])
	cause_update(variable_to_update)
# Removes an effect from the component
func remove_effect(effect: BaseEffect,variable_to_update) -> void:
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

	var unique_modifiers =  Utils.parse_effect_modifiers_from_children(self,variable_to_update )
	# Calculate the total modifier percentage	
	var modifier_value = Utils.calculate_modifier_from_dict(unique_modifiers) 
	owner.update_modifier( variable_to_update,modifier_value)
