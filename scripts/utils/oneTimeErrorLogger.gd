# ErrorLogger.gd
extends Node

# Singleton to be used across the project
class_name ErrorLogger

# Static dictionary to keep track of printed errors
static var printed_errors: Dictionary = {}

# Prints the error message only once
func print_once(prin_id: String, messages: Array, print_sign: String="error" ) -> void:
	# Check if the message has already been printed
	if printed_errors.has(prin_id):
		return  # If already printed, do nothing

	# Mark this message as printed
	printed_errors[prin_id] = true

	# Join all arguments into a single string
	var combined_message = str( messages,  )

	# Print based on the `prin_sign` argument
	match print_sign:
		"print":
			print(combined_message)  # Normal print
		"error":
			push_error(combined_message)  # Print error
		
		"info":
			print(combined_message)  # Info - same as print but can be used for additional context
		_:
			print("Unknown print sign:", print_sign, combined_message)  # Handle unknown print sign
			print(combined_message)  # Normal print
# Resets the error tracking, allowing messages to be printed again
static func reset():
	printed_errors.clear()
 
