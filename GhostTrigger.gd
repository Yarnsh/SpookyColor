extends Area3D

@export var ghosts : Array[Node3D]
@export var whisper : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	body.play_sfx(whisper, -13.0)
	for ghost in ghosts:
		ghost.show()
		ghost.get_node("AnimationPlayer").play("walk")
	set_deferred("monitoring", false)


func _on_animation_player_animation_finished(anim_name):
	for ghost in ghosts:
		ghost.hide()
