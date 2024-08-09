extends Node3D

@export var cams : Array[Node3D]

var pitch = 0.0
var yaw = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	global_rotation = Vector3(pitch, yaw, 0.0)
	for cam in cams:
		cam.global_position = global_position
		cam.global_rotation = global_rotation

func _input(event):
	if event is InputEventMouseMotion:
		pitch -= event.relative.y * 0.01
		yaw -= event.relative.x * 0.01
		pitch = clampf(pitch, -PI/2.0 + 0.1, PI/2.0 - 0.1)
