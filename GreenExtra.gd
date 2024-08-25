extends Node3D

@export var stuff : Array[Node3D]
@export var buganim : AnimationPlayer
@export var presanctum : Node3D

func trigger():
	for thing in stuff:
		thing.hide()
	buganim.play("BugsLeave")
	presanctum.disable()
