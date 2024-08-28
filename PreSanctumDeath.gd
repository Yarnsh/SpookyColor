extends Area3D

@onready var death = $Death
@onready var anim = $Death/warning/AnimationPlayer
@onready var sound = $Death/AudioStreamPlayer3D
@export var death_text = "The mistakes of those before you should be heeded."
@export var killnoise : AudioStream
var char = null
var start = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if char != null:
		death.global_position = char.global_position
		if Time.get_ticks_msec() - start > 2250:
			char.kill(death_text, killnoise, 0)


func _on_body_entered(body):
	print("die")
	call_deferred("set_monitoring", false)
	char = body
	anim.play("Object_4Action_001")
	sound.play()
	start = Time.get_ticks_msec()
