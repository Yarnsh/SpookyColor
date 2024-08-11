extends CharacterBody3D

@onready var cam = $RootCam
@onready var foot_sfx = $Foot

const SPEED = 3.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var was_on_floor = false
var was_moving = false
var foot_start_time = 999999999999.9
const foot_delay = 500

func _physics_process(delta):
	var now = Time.get_ticks_msec()
	
	# debug stuff
	if Input.is_action_just_pressed("change_windowed"): # can probably keep this and not just have it be debug
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1000, 600)) # TODO: use configured res
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	# real stuff
	if is_on_floor(): # TODO remember how good footsteps happen
		if !was_on_floor or (was_moving and now >= foot_start_time + foot_delay):
			foot_start_time = now
			foot_sfx.play()
		velocity = Vector3(0.0,velocity.y,0.0)
		if !was_moving:
			foot_start_time = Time.get_ticks_msec()
		was_moving = false
		if Input.is_action_pressed("left"):
			velocity += Vector3.LEFT.rotated(Vector3.UP, cam.yaw) * SPEED
			was_moving = true
		if Input.is_action_pressed("right"):
			velocity += Vector3.RIGHT.rotated(Vector3.UP, cam.yaw) * SPEED
			was_moving = true
		if Input.is_action_pressed("forward"):
			velocity += Vector3.FORWARD.rotated(Vector3.UP, cam.yaw) * SPEED
			was_moving = true
		if Input.is_action_pressed("back"):
			velocity += Vector3.BACK.rotated(Vector3.UP, cam.yaw) * SPEED
			was_moving = true
		
		if (Input.is_action_just_released("left")
			or Input.is_action_just_released("right")
			or Input.is_action_just_released("back")
			or Input.is_action_just_released("forward")):
			foot_sfx.play()
		
		was_on_floor = true
	else:
		velocity.y -= gravity * delta
		was_on_floor = false
	
	move_and_slide()
