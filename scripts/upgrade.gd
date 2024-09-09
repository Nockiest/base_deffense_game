# Upgrade.gd
extends Resource
class_name Upgrade

@export var upgrade_type: String = "generic"  # e.g., "damage", "speed"
@export var amount: int = 1                   # The amount this upgrade changes the stat
@export var description: String = "Base upgrade"
## a node it can be applied to, must be completely idnetical to the node calle
## in apply
var applicable_target = preload('res://scripts/projectiles/bullet/bullet.gd')
# Apply the upgrade to a target object
func apply(target):
	# Implement specific logic in subclasses or handle in UpgradeManager
	print_debug('x',target.get_script(),applicable_target.new().get_script())
	if target.get_script() == applicable_target.new().get_script():
		print('can apply to target')
