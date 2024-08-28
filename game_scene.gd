extends Node3D

@onready var main_scene = $".."

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
@onready var ocean_sounds = $Scene/OceanSounds
@onready var finish_trigger = $Scene/Finish
@onready var post_green_trigger = $Scene/PostGreenCheckpoint

var outdoor_visuals = true
var nail_taken = false
var door_locked = false
var colors = [false, false, false]
var spinner_solved = false
var post_green = false

func update_player_stuff():
	player_pos = ($Character).global_position
	cam_rot = ($Character/RootCam).global_rotation
	
	# a reasonable enough place to save to file
	main_scene.save_flags(get_flags())

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
	
	spinner_solved = flags.get("spinner_solved", false)
	if spinner_solved:
		spinner.set_finished()
	
	if colors[1]:
		green_pickup.set_finished()
		character.set_flag(1)
	
	if flags.get("post_green", false):
		post_green_trigger.set_deferred("monitoring", false)
	
	if colors[2]:
		blue_pickup.set_finished()
		character.set_flag(2)
	if colors[0] and colors[1] and colors[2]:
		start_exit_sequence()

func get_flags():
	return {
		"player_pos": player_pos,
		"cam_rot": cam_rot,
		"outdoor_visuals": outdoor_visuals,
		"nail_taken": nail_taken,
		"door_locked": door_locked,
		"colors": colors,
		"spinner_solved": spinner_solved,
		"post_green": post_green
	}

func start_exit_sequence():
	nail_slot.unlock()
	ocean_sounds.ending = true
	ocean_sounds.volume_db = -40.0
	ocean_sounds.play()
	finish_trigger.monitoring = true
	pass # TODO: reopen door out, change the triggers to restart the water sounds, setup the trigger for the credits kill
