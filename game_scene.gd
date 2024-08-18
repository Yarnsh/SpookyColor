extends Node3D

@onready var player_pos = ($Character).global_position
@onready var cam_rot = ($Character/RootCam).global_rotation

@onready var character = $Character
@onready var cam = $Character/RootCam
@onready var nail_slot = $Scene/StaffSlot

var nail_taken = false

func update_player_stuff():
	player_pos = ($Character).global_position
	cam_rot = ($Character/RootCam).global_rotation

func apply_flags(flags):
	player_pos = flags.get("player_pos", player_pos)
	character.global_position = player_pos
	cam_rot = flags.get("cam_rot", cam_rot)
	cam.set_grot(cam_rot)
	
	nail_taken = flags.get("nail_taken", false)
	if nail_taken:
		nail_slot.set_finished()

func get_flags():
	return {
		"player_pos": player_pos,
		"cam_rot": cam_rot,
		"nail_taken": nail_taken
	}
