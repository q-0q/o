extends MeshInstance3D

@export var max_speed = 0.05
@export var acceleration_time = 0.2
@export var stop_time = 0.1
@export var input_dir_deadzone_size = 0.05
@export var look_speed_multiplier = 3.25
@export var look_range_radians = 0.9

var look_angle_speed_curve : Curve

func _ready():
	look_angle_speed_curve = load("res://Resource/Curve/player_look_angle_speed_curve.tres")
	
func _process(delta):
	move(delta)
	$CameraHolder.set_player_pos(position)

func move(delta):
	var input2 = Vector2.ZERO
	if (Input.is_action_pressed("move_left")): input2 += Vector2.LEFT
	if (Input.is_action_pressed("move_right")): input2 += Vector2.RIGHT
	if (Input.is_action_pressed("move_forward")): input2 += Vector2.UP
	if (Input.is_action_pressed("move_backward")): input2 += Vector2.DOWN
	
	var speed = 0.0
	if input2.length() > input_dir_deadzone_size:
		speed = max_speed
	
	speed = clamp(speed, 0.0, max_speed)
	var direction_to_cursor = $CameraHolder.position.normalized()
	var input3 = (Vector3(input2.x, 0, input2.y)).normalized()
	
	$LineToInput.look_at(position + input3, Vector3.LEFT)

	
	var angle = direction_to_cursor.angle_to(input3)
	var w = max(inverse_lerp(look_range_radians, 0, angle), 0)
	var delta_pos = Vector3.ZERO		
	var sample = look_angle_speed_curve.sample(w)
	var move_direction = lerp(input3, direction_to_cursor, sample).normalized()
	delta_pos = move_direction * lerp(speed, speed * look_speed_multiplier, sample)
	
	
	position += delta_pos
	$LineToMove.look_at(position + delta_pos, Vector3.LEFT)
	

func _on_game_cursor_computed_camera_position(camera_position):
	$CameraHolder.set_canonical_camera_position(camera_position)
