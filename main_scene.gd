extends Node3D

@export var game_prefab : PackedScene
var game_scene = null

@onready var main = $Menus/Main
@onready var settings = $Menus/Settings
@onready var controls = $Menus/Controls

var mode = 1
var loaded_flags = {}

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_window().grab_focus()
	
	loaded_flags = load_flags()
	if loaded_flags != {}:
		main.resume_button.text = "Continue"
		main.resume_button.disabled = false

func resume():
	if game_scene == null:
		start_game(loaded_flags)
	set_mode(0)

func start_game(flags):
	if game_scene != null:
		remove_child(game_scene)
		game_scene.free()
	
	game_scene = game_prefab.instantiate()
	add_child(game_scene)
	game_scene.apply_flags(flags)
	
	main.resume_button.text = "Resume"
	main.resume_button.disabled = false

func get_fov():
	return settings.fov.value

func set_mode(new_mode):
	mode = new_mode
	
	if mode == 0:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	main.hide()
	settings.hide()
	controls.hide()
	# mode 0 is no menus open, the actual game
	if mode == 1:
		main.show()
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

func load_flags():
	if not FileAccess.file_exists("user://save.dat"):
		save_flags({})
		return {}

	var file := FileAccess.open("user://save.dat", FileAccess.READ)
	var flags: Dictionary = file.get_var(true)
	file.close()
	
	return flags

func save_flags(flags):
	var file := FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_var(flags, true)
	file.close()
