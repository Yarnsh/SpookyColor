extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(kill)

func kill(body):
	if body is CharacterBody3D:
		body.kill()
		# TODO: supply a different death noise based on what death we got
