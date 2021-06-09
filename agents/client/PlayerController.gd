class_name PlayerController
extends AgentController


onready var agent : KinematicBody2D = get_parent()
var destination = null


func _unhandled_input(_event):
	if Input.is_action_pressed("ui_leftclick"):
		destination = get_global_mouse_position()
		rpc("update_destination", destination)
