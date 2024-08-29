class_name CraftingComponent
extends Component

@export var craftingCost: = 10.0
@export var inputResources:Array[Ingredient]    # List of required input resources
var outputResource     # The output resource produced

var craftingTimer: float = 0.0
var isCrafting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isCrafting:
		craftingTimer += delta
		if craftingTimer >= craftingCost:
			_complete_crafting()

# Start the crafting process with the given resources
func craft(resources: Array) -> void:
	if not _has_required_resources(resources):
		print("Missing required resources!")
		return

	# Consume the input resources
	_consume_resources(resources)

	# Start the crafting timer
	craftingTimer = 0.0
	isCrafting = true

# Check if the given resources match the required input resources
func _has_required_resources(resources: Array) -> bool:
	for required in inputResources:
		if not resources.has(required):
			return false
	return true

# Consume the resources used in crafting
func _consume_resources(resources: Array) -> void:
	for required in inputResources:
		resources.erase(required) # Remove the resource from the input array

# Complete the crafting process and produce the output resource
func _complete_crafting() -> void:
	isCrafting = false
	craftingTimer = 0.0
	# Add the output resource to the player's inventory or scene
	_produce_output()

func _produce_output() -> void:
	if outputResource:
		# Logic to add the output resource to the inventory or scene
		print("Crafting complete! Produced: ", outputResource)
		emit_signal('output', outputResource)
	else:
		print("No output resource defined!")
