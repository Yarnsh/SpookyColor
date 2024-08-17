extends Node3D

@onready var target = $"../NailInPos"
@onready var in_t = $"../NailInPos"
@onready var out_t = $"../NailOutPos"
@onready var power = $Spin/Power
@onready var outline = $Spin/Outline
@onready var light = $Spin/Light

@onready var on_off_dist = in_t.position.distance_to(out_t.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rate = 50
	if target == in_t:
		rate = 20
	transform = transform.interpolate_with(target.transform, (rate * delta)*(rate * delta))
	
	if target == in_t:
		light.omni_range = 15.0 * (target.position.distance_to(position) / on_off_dist)
		if position.distance_squared_to(target.position) < 0.1:
			hide()
	else:
		light.omni_range = 15.0 * (1.0 - (target.position.distance_to(position) / on_off_dist))
		if position.distance_squared_to(target.position) < 0.1:
			show()

func set_out():
	target = out_t

func set_in():
	target = in_t

func toggle():
	if target == in_t:
		target = out_t
	else:
		target = in_t

func set_flags(red, green, blue):
	var col = Color.BLACK
	var ol = 0.0
	if red:
		col.r = 1.0
		light.light_color.r = 1.0
		ol += 0.01
	else:
		col.r = 0.0
		light.light_color.r = 0.0
	if green:
		col.g = 1.0
		light.light_color.g = 1.0
		ol += 0.4
	else:
		col.g = 0.0
		light.light_color.g = 0.0
	if blue:
		col.b = 1.0
		light.light_color.b = 1.0
		ol += 0.5
	else:
		col.b = 0.0
		light.light_color.b = 0.0
	
	power.mesh.surface_get_material(0).albedo_color = col
	if col == Color.BLACK:
		outline.hide()
		power.hide()
	else:
		outline.mesh.surface_get_material(0).set_shader_parameter("albedo", Color8(int(255 * ol), int(255 * ol), int(255 * ol)))
		outline.show()
		power.show()
	
	if ol > 0.2:
		light.show()
	else:
		light.hide()
