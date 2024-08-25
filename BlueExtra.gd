extends Node3D

@export var on : Array[Node3D]
@export var off: Array[Node3D]
@export var sanctum_puzzle : Node3D

func trigger():
	for thing in on:
		thing.show()
	for thing in off:
		thing.hide()
	sanctum_puzzle.disable()
