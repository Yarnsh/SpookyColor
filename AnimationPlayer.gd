extends AnimationPlayer

@export var mesh : MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("walk")
	mesh.set_layer_mask_value(1, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mesh.set_layer_mask_value(2, true)
