extends MeshInstance3D

@export var max_speed = 1
@export var acceleration_rate = 0.1
@export var stop_rate = 10
@export var input_dir_deadzone_size = 0.05

var speed = 0.0
var time_spent_accelerating = 0.0
var time_spent_stopping = 0.0

func _process(delta):
	move(delta)

func move(delta):
	var input2 = Vector2.ZERO
	if (Input.is_action_pressed("move_left")): input2 += Vector2.LEFT
	if (Input.is_action_pressed("move_right")): input2 += Vector2.RIGHT
	if (Input.is_action_pressed("move_forward")): input2 += Vector2.UP
	if (Input.is_action_pressed("move_backward")): input2 += Vector2.DOWN
	
	if input2.length() > input_dir_deadzone_size:
		speed += acceleration_rate * delta
	else:
		speed -= stop_rate * delta
	
	speed = clamp(speed, 0, max_speed)
	print(speed)
	
	position += $CameraHolder.position.normalized() * speed
	

func _on_game_cursor_computed_camera_position(position):
	$CameraHolder.set_canonical_camera_position(position)
