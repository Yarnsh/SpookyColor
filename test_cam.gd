extends Node3D

@export var cams : Array[Node3D]

var pitch = 0.0
var yaw = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = Vector3(pitch, yaw, 0.0)
	if Input.is_action_pressed("left"):
		translate(Vector3.LEFT * 5.0 * delta)
	if Input.is_action_pressed("right"):
		translate(Vector3.RIGHT * 5.0 * delta)
	if Input.is_action_pressed("forward"):
		translate(Vector3.FORWARD * 5.0 * delta)
	if Input.is_action_pressed("back"):
		translate(Vector3.BACK * 5.0 * delta)
	
	for cam in cams:
		cam.global_position = global_position
		cam.global_rotation = global_rotation

func _input(event):
	if event is InputEventMouseMotion:
		pitch -= event.relative.y * 0.01
		yaw -= event.relative.x * 0.01
		pitch = clampf(pitch, -PI/2.0 + 0.1, PI/2.0 - 0.1)
