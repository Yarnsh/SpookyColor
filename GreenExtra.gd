extends Node3D

@export var stuff : Array[Node3D]

func trigger():
	for thing in stuff:
		thing.hide()
