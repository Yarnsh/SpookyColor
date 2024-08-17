extends MeshInstance3D

@export var pos = 0
@onready var sfx = $SFX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target = Quaternion(Vector3.FORWARD, (2.0*PI) * ((float(pos) / 12.0)))
	var rate = 50
	quaternion = quaternion.slerp(target, (rate * delta)*(rate * delta))

func interact(c):
	pos = (pos + 1) % 12
	get_parent().interact(c)
	sfx.play()

func disable():
	get_child(0).set_collision_layer_value(2, false)
