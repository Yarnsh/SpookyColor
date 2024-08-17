extends Node3D

@export var DoorL : Node3D
@export var DoorR : Node3D
@onready var sfx = $SFX
var moving = false
const door_offset = 4.5
const door_speed = 0.7

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
