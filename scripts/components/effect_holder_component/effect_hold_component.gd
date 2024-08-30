class_name EffectHoldComponent
extends Component

# Holds effects like fire damage, freeze, etc.

# Adds an effect to the component as a child node
func add_effect(effect: BaseEffect) -> void:
	if effect and effect not in get_children():
		add_child(effect)
		print("Effect added:", owner, effect.name)
	else:
		oneErr.printerr_once('invalid effect', ["Effect already exists or is invalid:", effect, owner])

# Removes an effect from the component
func remove_effect(effect: BaseEffect) -> void:
	if effect in get_children():
		remove_child(effect)
		print("Effect removed:", effect.name)
	else:
		oneErr.printerr_once( 'effect holder without effect',["Effect holder doesn't have the effect:", effect, owner])
