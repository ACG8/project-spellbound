extends KinematicBody2D


var max_speed = 400
var speed = 0
var acceleration = 1200
var friction = 1200
var controller : AgentController


func _physics_process(delta):
	movement_loop(delta)


func activate_camera():
	$Camera2D.make_current()


func movement_loop(delta):
	if has_node("Controller") and get_node("Controller").destination != null:
		var destination = get_node("Controller").destination
		speed = clamp(speed + acceleration * delta, 0, max_speed)
		var movement = position.direction_to(destination) * speed
		var move_direction = rad2deg(destination.angle_to_point(position))
		if position.distance_to(destination) > 5:
			movement = move_and_slide(movement)
	else:
		speed = clamp(speed - acceleration * delta, 0, max_speed)
