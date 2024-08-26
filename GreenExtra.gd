extends Node3D

@export var stuff : Array[Node3D]
@export var buganim : AnimationPlayer
@export var presanctum : Node3D
@export var sanctum_puzzle : Node3D

func trigger(char):
	for thing in stuff:
		thing.hide()
	buganim.play("BugsLeave")
	presanctum.disable()
	sanctum_puzzle.enable()
	if char != null:
		char.nail_toggle = false
