extends Node3D

var canonical_camera_position : Vector3

func set_canonical_camera_position(position : Vector3):
	canonical_camera_position = position

func _process(delta):
	position = lerp(position, canonical_camera_position, delta * 20)
