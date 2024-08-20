extends Area3D

@export var water : Node3D
@export var color_cam : Camera3D
@export var meshes : Node3D
@onready var outdoor_env = load("res://visual_env.tres")
@onready var game_scene = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	set_active()
	game_scene.outdoor_visuals = true

func set_active():
	water.show()
	#color_cam.environment = outdoor_env
	#meshes.show()
