extends Node3D

@onready var target = $"../NailInPos"
@onready var in_t = $"../NailInPos"
@onready var out_t = $"../NailOutPos"
@onready var power = $Spin/Power
@onready var outline = $Spin/Outline

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rate = 50
	if target == in_t:
		rate = 20
	transform = transform.interpolate_with(target.transform, (rate * delta)*(rate * delta))
	
	if target == in_t and position.distance_squared_to(target.position) < 0.1:
		hide()
	else:
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

func set_colors(col):
	power.mesh.get_active_material().albedo_color = col
	if col == Color.BLACK:
		outline.hide()
	else:
		outline.show()
