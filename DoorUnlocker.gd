extends Node3D

@export var DoorL : Node3D
@export var DoorR : Node3D

const door_offset = -2.5

func unlock():
	DoorR.global_position.x = r_start + door_offset
	DoorL.global_position.x = l_start - door_offset
