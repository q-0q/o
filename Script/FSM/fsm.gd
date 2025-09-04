extends Node3D

class_name FSM

@export var start_state : State
var current_state : State

func _process(delta):
	_fire()

func _fire():
	pass
