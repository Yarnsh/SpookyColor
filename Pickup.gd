extends StaticBody3D

@export var flag = 0
@onready var game_scene = $"../.."
@export var extra_trigger : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(c):
	c.set_flag(flag)
	set_collision_layer_value(2, false)
	hide()
	game_scene.colors[flag] = true
	game_scene.update_player_stuff()
	if game_scene.colors[0] and game_scene.colors[1] and game_scene.colors[2]:
		game_scene.start_exit_sequence()
	if extra_trigger != null:
		extra_trigger.trigger(c)

func set_finished():
	set_collision_layer_value(2, false)
	hide()
	if extra_trigger != null:
		extra_trigger.trigger(null)
