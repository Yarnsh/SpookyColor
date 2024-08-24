extends Node3D

@export var stuff : Array[Node3D]
@export var buganim : AnimationPlayer

func trigger():
	for thing in stuff:
		thing.hide()
	buganim.play("BugsLeave")
