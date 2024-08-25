extends Area3D

@export var ghosts : Array[Node3D]
@export var whisper : AudioStream
var next_ghost = 0
var playing =  false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing and next_ghost < Time.get_ticks_msec():
		var ghost = ghosts.pop_front()
		ghost.show()
		ghost.get_node("AnimationPlayer").play("walk")
		next_ghost = Time.get_ticks_msec() + 1000
		if ghosts.size() <= 0:
			playing = false


func _on_body_entered(body):
	body.play_sfx(whisper, -13.0)
	playing = true
	set_deferred("monitoring", false)


func _on_animation_player_animation_finished(anim_name):
	for ghost in ghosts:
		ghost.hide()
