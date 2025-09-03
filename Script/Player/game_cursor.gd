extends Node

var pan_curve : Curve

@export var deadzone_size = 0
@export var maxzone_size = 1
@export var pan_distance = 6

signal computed_camera_position(position : Vector2)

func _ready():
	pan_curve = load("res://Resource/Curve/game_cursor_pan_curve.tres")
	Input.set_custom_mouse_cursor(load("res://Asset/2D/Sprite/Cursor.png"), 0, Vector2(16, 16))

func _input(event):
	if event is not InputEventMouseMotion: return
	var viewport_size = get_viewport().get_visible_rect().size
	var cursor_screen_normal = get_normalized_point(viewport_size, event.position)
	var distance = min(1, cursor_screen_normal.length())
	var sample = pan_curve.sample(distance)
	var camera_position_2 = cursor_screen_normal * sample * pan_distance
	var camera_position_3 = Vector3(camera_position_2.x, 0, camera_position_2.y)
	computed_camera_position.emit(camera_position_3)
	
func get_normalized_point(rect_size : Vector2, point : Vector2):
	var half_size = rect_size * 0.5
	var centered_point = point - half_size
	return Vector2(
		centered_point.x / half_size.x,
		centered_point.y / half_size.y
	)
	
