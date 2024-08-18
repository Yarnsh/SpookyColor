extends Node3D

@onready var game_scene = $"../.."
@export var DoorL : Node3D
@export var DoorR : Node3D
@onready var sfx = $SFX
var moving = false
const door_offset = 4.5
const door_speed = 1.4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		DoorR.global_position.x = min(DoorR.global_position.x + door_speed * delta, door_offset)
		DoorL.global_position.x = max(DoorL.global_position.x - door_speed * delta, -door_offset)
		global_position.x = min(global_position.x + door_speed * delta, door_offset)
		if DoorL.global_position.x <= -door_offset:
			moving = false

func interact(c):
	for child in get_children():
		if child == sfx:
			continue
		if child.pos != 0:
			return
	moving = true
	sfx.play()
	for child in get_children():
		if child == sfx:
			continue
		child.disable()
	game_scene.spinner_solved = true
	game_scene.update_player_stuff()

func set_finished():
	for child in get_children():
		if child == sfx:
			continue
		child.pos = 0
		child.disable()
	DoorR.global_position.x = door_offset
	DoorL.global_position.x = -door_offset
	global_position.x = door_offset
