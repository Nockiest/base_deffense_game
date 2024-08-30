# ErrorLogger.gd
extends Node

# Singleton to be used across the project
class_name ErrorLogger

# Static dictionary to keep track of printed errors
static var printed_errors: Dictionary = {}

# Prints the error message only once
static func printerr_once(sign:String,messages:   Array):
	# Join all arguments into a single string to use as the key
	if printed_errors.has(sign):
		return  # If already printed, do nothing
	printed_errors[sign] = true  # Mark message as printed
	printerr(messages)  # Print the combined message

# Resets the error tracking, allowing messages to be printed again
static func reset():
	printed_errors.clear()
 
