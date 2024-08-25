extends Node3D

var n = 0
var next_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Global.now >= next_time:
		var ghost = get_child(n).get_node("AnimationPlayer")
		n = (n+1)%get_child_count()
		ghost.stop()
		ghost.play("walk")
		next_time = Global.now + 500
