extends Node3D

@export var game_prefab : PackedScene
var game_scene = null

@onready var settings = $Menus/Settings

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
