extends CharacterBody3D

@onready var cam = $RootCam

const SPEED = 3.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# debug stuff
	if Input.is_action_just_pressed("change_windowed"): # can probably keep this and not just have it be debug
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1000, 600)) # TODO: use configured res
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	# real stuff
	if is_on_floor():
		velocity = Vector3(0.0,velocity.y,0.0)
		if Input.is_action_pressed("left"):
			velocity += Vector3.LEFT.rotated(Vector3.UP, cam.yaw) * SPEED
		if Input.is_action_pressed("right"):
			velocity += Vector3.RIGHT.rotated(Vector3.UP, cam.yaw) * SPEED
		if Input.is_action_pressed("forward"):
			velocity += Vector3.FORWARD.rotated(Vector3.UP, cam.yaw) * SPEED
		if Input.is_action_pressed("back"):
			velocity += Vector3.BACK.rotated(Vector3.UP, cam.yaw) * SPEED
	else:
		velocity.y -= gravity * delta
	
	move_and_slide()
