extends Node3D

@export var on : Array[Node3D]
@export var off: Array[Node3D]
@export var statues : Node3D
@export var npc : Node3D

func trigger(char):
	for thing in on:
		thing.show()
	for thing in off:
		thing.hide()
	if char != null:
		char.cam.set_popup("Press " + InputMap.action_get_events("Use_Nail")[0].as_text())
	statues.set_state(2)
	npc.global_position.y = -500
