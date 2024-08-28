extends Node3D

@export var stuff : Array[Node3D]
@export var buganim : AnimationPlayer
@export var presanctum : Node3D
@export var sanctum_puzzle : Node3D

@export var doorl : Node3D
@export var doorr : Node3D
@export var post_green_checkpoint : Area3D

func trigger(char):
	for thing in stuff:
		thing.hide()
	buganim.play("BugsLeave")
	presanctum.disable()
	sanctum_puzzle.enable()
	if char != null:
		char.nail_toggle = false
	doorl.global_position.x = 0.0
	doorr.global_position.x = 0.0
	post_green_checkpoint.set_deferred("monitoring", true)
	print(doorl.global_position.x)
