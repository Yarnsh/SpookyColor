extends Area3D

@export var water : Node3D
@export var color_cam : Camera3D
@onready var indoor_env = load("res://default_env.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	water.hide()
	color_cam.environment = indoor_env
