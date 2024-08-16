extends MeshInstance3D

var start_pos

@export var SPEED = 1.0
@export var AMP = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#var now = Time.get_ticks_msec()
	#global_position = start_pos + Vector3.RIGHT * sin(now * SPEED * 0.001) * AMP
	#TODO: split this on xyz, and also add more noise somehow (use a noise texture somehow?)
