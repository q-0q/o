extends Node3D

var canonical_camera_position : Vector3
var player_position : Vector3

func set_canonical_camera_position(position : Vector3):
	canonical_camera_position = position

func set_player_pos(player_pos):
	player_position = player_pos

func _process(delta):
	position = lerp(position, canonical_camera_position, delta * 20)
	$LineToCameraHolder.look_at(player_position, Vector3.LEFT)
