extends Area3D

@export var DoorL : Node3D
@export var DoorR : Node3D
@export var sea_sounds : AudioStreamPlayer3D
@onready var boom = $Boom

const door_offset = -2.5
const door_speed = 20.7

var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activated:
		DoorR.global_position.x = max(DoorR.global_position.x - door_speed * delta, 0)
		DoorL.global_position.x = min(DoorL.global_position.x + door_speed * delta, 0)
		if DoorL.global_position.x >= 0:
			set_process(false)
			sea_sounds.stop()
			boom.play()
			AudioServer.set_bus_effect_enabled(1, 0, true)


func _on_body_entered(body):
	if !activated:
		activated = true
