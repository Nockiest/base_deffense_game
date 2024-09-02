class_name EffectHoldComponent
extends Component

# Holds effects like fire damage, freeze, etc.
@export var effect_variable_names:Array[String] = ['speed_modifier_change']
# Adds an effect to the component as a child node
func add_effect(effect: BaseEffect) -> void:
	if effect and effect not in get_children():
		add_child(effect)
		print("Effect added:", owner, effect.name)
	else:
		oneErr.printerr_once('invalid effect', ["Effect already exists or is invalid:", effect, owner])
	cause_update()
# Removes an effect from the component
func remove_effect(effect: BaseEffect) -> void:
	if effect in get_children():
		remove_child(effect)
		print("Effect removed:", effect.name)
	else:
		oneErr.printerr_once( 'effect holder without effect',["Effect holder doesn't have the effect:", effect, owner])
	cause_update()

func cause_update():
	for effect_variable in effect_variable_names:
		# Remove '_change' suffix from the effect variable name
		var base_variable_name = effect_variable.replace('_change', '')
		
		# Check if the owner has the base variable
		if owner and base_variable_name in owner:
			# Get the value of the owner's base variable
			var base_value = owner.get(base_variable_name)
			if owner.has_method('update_modifier'):
				owner.update_modifier(base_value, effect_variable)
			else:
				printerr('Owner does not have update_modifier method:', owner)
		else:
			printerr('Owner does not have the variable:', base_variable_name)
