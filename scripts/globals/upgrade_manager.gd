##class_name UpgradeManager

extends Node

## contains all types of purchased uprades
var active_upgrades = {
   'test':Upgrade.new()
}

# Apply an upgrade and store it
func apply_upgrades(node: Node) -> void:
	
	for upgrade  in active_upgrades:
		active_upgrades[upgrade].apply(node)
	#if not active_upgrades.has(upgrade.upgrade_type):
		#active_upgrades[upgrade.upgrade_type] = []
	#
	#active_upgrades[upgrade.upgrade_type].append(upgrade)
	#emit_signal("upgrade_applied", upgrade)  # Optional: signal when an upgrade is applied

# Get active upgrades of a specific type
func get_active_upgrades(upgrade_type: String) -> Array:
	return active_upgrades.get(upgrade_type, [])
