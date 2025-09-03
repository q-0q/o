extends MeshInstance3D

@export var max_speed = 0.05
@export var acceleration_time = 0.2
@export var stop_time = 0.1
@export var input_dir_deadzone_size = 0.05
@export var look_speed_multiplier = 2.25
@export var look_range_radians = 0.75

var look_angle_speed_curve : Curve
var speed = 0.0
var look_speed = 0.0

func _ready():
	look_angle_speed_curve = load("res://Resource/Curve/player_look_angle_speed_curve.tres")
	
func _process(delta):
	move(delta)

func move(delta):
	var input2 = Vector2.ZERO
	if (Input.is_action_pressed("move_left")): input2 += Vector2.LEFT
	if (Input.is_action_pressed("move_right")): input2 += Vector2.RIGHT
	if (Input.is_action_pressed("move_forward")): input2 += Vector2.UP
	if (Input.is_action_pressed("move_backward")): input2 += Vector2.DOWN
	
	if input2.length() > input_dir_deadzone_size:
		speed += delta * max_speed / acceleration_time
	else:
		speed -= delta * max_speed / stop_time
	
	speed = clamp(speed, 0, max_speed)
	var look = $CameraHolder.position.normalized()
	var input3 = (Vector3(input2.x, 0, input2.y)).normalized()
	var angle = look.angle_to(input3)
	var w = angle / look_range_radians
	if angle < look_range_radians:
		var look_mod = look_angle_speed_curve.sample(w)
		print(look_mod)
		position += look * speed * look_mod
		
	else:
		position += input3 * speed
	

func _on_game_cursor_computed_camera_position(position):
	$CameraHolder.set_canonical_camera_position(position)
