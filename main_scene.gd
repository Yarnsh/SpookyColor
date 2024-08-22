extends Node3D

@export var game_prefab : PackedScene
var game_scene = null

@onready var settings = $Menus/Settings
@onready var controls = $Menus/Controls

var mode = 1

func _ready():
	start_game({})

func start_game(flags):
	if game_scene != null:
		remove_child(game_scene)
		game_scene.free()
	
	game_scene = game_prefab.instantiate()
	add_child(game_scene)
	game_scene.apply_flags(flags)

func get_fov():
	return settings.fov.value

func set_mode(new_mode):
	mode = new_mode
	settings.hide()
	controls.hide()
	# mode 0 is no menus open, the actual game
	if mode == 1:
		pass # TODO: main menu
	elif mode == 2:
		settings.show()
	elif mode == 3:
		controls.show()

func _input(event):
	if event.is_action_pressed("menu"):
		if mode == 0:
			set_mode(1)
		elif mode == 1:
			set_mode(0)
		elif mode == 2:
			set_mode(1)
		elif mode == 3:
			set_mode(2)
