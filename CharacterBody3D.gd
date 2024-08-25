extends CharacterBody3D

@onready var main_scene = $"../.."
@onready var game_scene = $".."

@onready var cam = $RootCam
@onready var view_pos = $RootCam/ViewPos
@onready var foot_sfx = $Foot
@onready var nail = $RootCam/Nail
var nail_toggle = false

@onready var sfx_player = $SFXPlayer

@onready var grassy_foot_step = load("res://SFX/footstep.wav")
@onready var stony_foot_step = load("res://SFX/stone_footstep.wav")
@export var grassy_collider : StaticBody3D

@onready var interact_1 = $"RootCam/InteractButton"
@onready var interact_2 = $"RootCam/InteractButton2"

var red = false
var green = false
var blue = false

var SPEED = 4.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var was_on_floor = false
var was_moving = false
var foot_start_time = 999999999999.9
const foot_delay = 850

const NORMAL_STATE = 0
const CUTSCENE_STATE = 1
var state = NORMAL_STATE
var cutscene_nail = false

func play_sfx(sound, db):
	sfx_player.stream = sound
	sfx_player.volume_db = db
	sfx_player.play()

func _process(delta):
	# bit of a waste to do this every frame but honestly who cares anymore
	interact_1.text = InputMap.action_get_events("interact")[0].as_text()
	interact_2.text = InputMap.action_get_events("interact")[0].as_text()

func _physics_process(delta):
	var now = Time.get_ticks_msec()
	
	# debug stuff
	if Input.is_action_just_pressed("change_windowed"): # can probably keep this and not just have it be debug
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1000, 600)) # TODO: use configured res
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if Input.is_action_just_pressed("restart"):
		get_tree().current_scene.show_credits()
		return
	if Input.is_action_pressed("speed_up"):
		SPEED = 22.0
	else:
		SPEED = 4.0
	
	if (state == NORMAL_STATE):
		if (red or green or blue) and Input.is_action_just_pressed("Use_Nail") and main_scene.mode == 0:
			nail_toggle = !nail_toggle
		if !(red or green or blue):
			nail_toggle = false
		if nail_toggle:
			nail.set_out()
		else:
			nail.set_in()
		
		if is_on_floor(): # TODO remember how good footsteps happen
			var col = get_last_slide_collision()
			if col != null:
				if col.get_collider() == grassy_collider:
					if foot_sfx.stream != grassy_foot_step:
						foot_sfx.stream = grassy_foot_step
						AudioServer.set_bus_effect_enabled(1, 0, false)
				else:
					if foot_sfx.stream != stony_foot_step:
						foot_sfx.stream = stony_foot_step
			
			if !was_on_floor or (was_moving and now >= foot_start_time + foot_delay):
				foot_start_time = now
				foot_sfx.play()
			velocity = Vector3(0.0,velocity.y,0.0)
			if !was_moving:
				foot_start_time = Time.get_ticks_msec()
			was_moving = false
			if main_scene.mode == 0:
				if Input.is_action_pressed("left"):
					velocity += Vector3.LEFT.rotated(Vector3.UP, cam.yaw)
					was_moving = true
				if Input.is_action_pressed("right"):
					velocity += Vector3.RIGHT.rotated(Vector3.UP, cam.yaw)
					was_moving = true
				if Input.is_action_pressed("forward"):
					velocity += Vector3.FORWARD.rotated(Vector3.UP, cam.yaw)
					was_moving = true
				if Input.is_action_pressed("back"):
					velocity += Vector3.BACK.rotated(Vector3.UP, cam.yaw)
					was_moving = true
			
			velocity = velocity.normalized() * SPEED
			
			if ((Input.is_action_just_released("left")
				or Input.is_action_just_released("right")
				or Input.is_action_just_released("back")
				or Input.is_action_just_released("forward"))
				and (velocity.x == 0 and velocity.y == 0)):
				foot_sfx.play()
			
			was_on_floor = true
		else:
			velocity.y -= gravity * delta
			was_on_floor = false
	
	elif (state == CUTSCENE_STATE):
		if is_on_floor():
			velocity.x = 0.0
			velocity.z = 0.0
		else:
			velocity.y -= gravity * delta
		
		if cutscene_nail:
			nail.set_out()
		else:
			nail.set_in()
	
	move_and_slide()

func set_flag(flag):
	if flag == 0:
		red = true
	if flag == 1:
		green = true
	if flag == 2:
		blue = true
	nail.set_flags(red,green,blue)

func kill(description, sound):
	main_scene.loaded_flags = game_scene.get_flags()
	main_scene.show_death(description, sound)
