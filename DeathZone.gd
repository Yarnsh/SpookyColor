extends Area3D

@export var death_text = ";_;"

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(kill)

func kill(body):
	if body is CharacterBody3D:
		body.kill(death_text, null) #TODO noise
