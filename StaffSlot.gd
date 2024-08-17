extends StaticBody3D

@export var DoorL : Node3D
@export var DoorR : Node3D
@onready var nail = $Nail
@onready var nail_sound = $NailSound
@onready var door_open_sound = $DoorOpenSound
var l_start
var r_start

var character = null
var moving = false
var interacting = false
const door_offset = 2.5
const door_speed = 0.7

const pull_out_time = 1200
const pull_to_face_time = 600
var nail_move_time = -1
var nail_pull_0
var nail_pull_1
var nail_done = false

func _ready():
	l_start = DoorL.global_position.x
	r_start = DoorR.global_position.x
	nail_pull_0 = nail.global_transform
	nail_pull_1 = nail.global_transform.translated(Vector3.UP * 1.5)

func inv_lerp(a, b, v):
	return (float(v)-float(a))/(float(b)-float(a))

func _process(delta):
	if nail_move_time >= 0 and character != null:
		var now = Time.get_ticks_msec()
		if now < nail_move_time + pull_out_time:
			var t = inv_lerp(nail_move_time, nail_move_time + pull_out_time, now)
			nail.global_transform = nail_pull_0.interpolate_with(nail_pull_1, t)
		elif now < nail_move_time + pull_out_time + pull_to_face_time:
			var t = inv_lerp(nail_move_time + pull_out_time, nail_move_time + pull_out_time + pull_to_face_time, now)
			nail.global_transform = nail_pull_1.interpolate_with(character.view_pos.global_transform, t)
		else:
			nail_done = true
			character.cam.set_button_visible(true)
	
	if character != null and interacting:
		var from = character.cam.quaternion
		var to = Basis.looking_at(nail.global_position - character.cam.global_position).get_rotation_quaternion()
		
		var rate = 50
		character.cam.quaternion = from.slerp(to, (rate * delta)*(rate * delta))
	
	if moving:
		DoorR.global_position.x = min(DoorR.global_position.x + door_speed * delta, r_start + door_offset)
		DoorL.global_position.x = max(DoorL.global_position.x - door_speed * delta, l_start - door_offset)
		if DoorL.global_position.x <= l_start - door_offset:
			moving = false

func interact(c):
	if !interacting:
		character = c
		moving = true
		interacting = true
		nail_move_time = Time.get_ticks_msec()
		set_collision_layer_value(2, false)
		character.state = character.CUTSCENE_STATE
		nail_sound.play()
		door_open_sound.play()
	elif nail_done:
		character.state = character.NORMAL_STATE
		character.cam.set_button_visible(false)
		character = null
		nail.hide()
