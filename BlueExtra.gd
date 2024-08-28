extends Node3D

@export var on : Array[Node3D]
@export var off: Array[Node3D]
@export var sanctum_puzzle : Node3D
@export var statues : Node3D

@export var doorl : Node3D
@export var doorr : Node3D
const door_offset = 4.5

func trigger(char):
	for thing in on:
		thing.show()
	for thing in off:
		thing.hide()
	sanctum_puzzle.disable()
	if char != null:
		char.cam.set_popup("I think it's time to leave")
	statues.set_state(3)
	
	doorl.global_position.x = -door_offset
	doorr.global_position.x = door_offset
