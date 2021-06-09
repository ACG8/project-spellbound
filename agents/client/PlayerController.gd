class_name PlayerController
extends AgentController


var destination = null


master func update_destination(new_destination):
	destination = new_destination


func _unhandled_input(_event):
	if Input.is_action_pressed("ui_leftclick"):
		destination = get_global_mouse_position()
		rset("destination", destination)
