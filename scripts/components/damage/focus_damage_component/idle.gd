extends State

 
func enter(_msg := {}) -> void:
	owner.focus_time = 0


func toggle_focus():
	print(state_machine)
	state_machine.transition_to('Focused')
		 
