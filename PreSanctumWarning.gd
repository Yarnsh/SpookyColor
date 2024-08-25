extends Area3D

@onready var spook = $Spook
@onready var anim = $Spook/warning/AnimationPlayer
@onready var sound = $Spook/AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	call_deferred("set_monitoring", false)
	spook.global_position.x = body.global_position.x
	anim.play("Object_4Action_001")
	sound.play()
