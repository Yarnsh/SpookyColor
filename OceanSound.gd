extends AudioStreamPlayer3D

@onready var fade_out_area = $Area3D
@export var character : CharacterBody3D

const door_volume = -2
const min_volume = -10
const max_x_dist = 30.0
const max_z_dist = 75.0
var start_z = 0
var end_z = 1

func _ready():
	# grab area collision shape for volume calculation
	var col = fade_out_area.get_child(0)
	var cols = col.get_shape() as BoxShape3D
	start_z = col.global_position.z + (cols.size.z / 2.0)
	end_z = col.global_position.z - (cols.size.z / 2.0)

func inv_lerp(a, b, v):
	return (v-a)/(b-a)

func _process(delta):
	if character in fade_out_area.get_overlapping_bodies():
		var z = clamp(character.global_position.z, end_z, start_z)
		z = inv_lerp(start_z, end_z, z)
		volume_db = lerp(door_volume, min_volume, z)
	else:
		var normalized = Vector2((global_position.x - character.global_position.x) / max_x_dist, (global_position.z - character.global_position.z) / max_z_dist)
		volume_db = door_volume * (1.0 - min(normalized.length(), 1.0))
