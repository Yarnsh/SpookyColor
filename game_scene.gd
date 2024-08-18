extends Node3D

@onready var player_pos = ($Character).global_position
@onready var cam_rot = ($Character/RootCam).global_rotation

@onready var character = $Character
@onready var cam = $Character/RootCam
@onready var ivisuals = $Scene/IndoorVisuals
@onready var ovisuals = $Scene/OutdoorVisuals
@onready var nail_slot = $Scene/StaffSlot
@onready var door_slammer = $Scene/DoorLocker
@onready var red_pickup = $Scene/RedPickup
@onready var green_pickup = $Scene/GreenPickup
@onready var blue_pickup = $Scene/BluePickup
@onready var spinner = $Scene/Spinner

var outdoor_visuals = true
var nail_taken = false
var door_locked = false
var colors = [false, false, false]
var spinner_solved = false

func update_player_stuff():
	player_pos = ($Character).global_position
	cam_rot = ($Character/RootCam).global_rotation

func apply_flags(flags):
	player_pos = flags.get("player_pos", player_pos)
	character.global_position = player_pos
	cam_rot = flags.get("cam_rot", cam_rot)
	cam.set_grot(cam_rot)
	
	outdoor_visuals = flags.get("outdoor_visuals", true)
	if outdoor_visuals:
		ovisuals.set_active()
	else:
		ivisuals.set_active()
	
	nail_taken = flags.get("nail_taken", false)
	if nail_taken:
		nail_slot.set_finished()
	
	door_locked = flags.get("door_locked", false)
	if door_locked:
		door_slammer.set_finished()
	
	colors = flags.get("colors", colors)
	if colors[0]:
		red_pickup.set_finished()
		character.set_flag(0)
	if colors[1]:
		green_pickup.set_finished()
		character.set_flag(1)
	if colors[2]:
		blue_pickup.set_finished()
		character.set_flag(2)
	
	spinner_solved = flags.get("spinner_solved", false)
	if spinner_solved:
		spinner.set_finished()

func get_flags():
	return {
		"player_pos": player_pos,
		"cam_rot": cam_rot,
		"outdoor_visuals": outdoor_visuals,
		"nail_taken": nail_taken,
		"door_locked": door_locked,
		"colors": colors,
		"spinner_solved": spinner_solved
	}
