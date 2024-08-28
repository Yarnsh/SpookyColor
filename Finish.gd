extends Area3D

@onready var main_scene = $"../../.."
@export var final_spook : Node
@export var sun : DirectionalLight3D
@export var shader_anim : AnimationPlayer
var final_spook_anim : AnimationPlayer
@export var finish_blocker : StaticBody3D
@onready var sun_anim = $AnimationPlayer
@onready var env = $"../WorldEnvironment"
@export var final_noise : AudioStreamPlayer3D
var character = null
var start_time = 0
const cutscene_time = 5.0

func _ready():
	final_spook_anim = final_spook.get_node("AnimationPlayer")
	final_spook.hide()

func _process(delta):
	if character != null:
		var now = float(Time.get_ticks_msec()) / 1000.0
		# TODO: move more darkness into place to block view
		
		if now > start_time + cutscene_time:
			character.state = character.NORMAL_STATE
		else:
			var from = character.cam.quaternion
			var to = Basis.looking_at(sun.global_basis.z).get_rotation_quaternion()
			var rate = 50
			character.cam.quaternion = from.slerp(to, (rate * delta)*(rate * delta))

func _on_body_entered(body):
	set_deferred("monitoring", false)
	character = body
	character.state = character.CUTSCENE_STATE
	character.cutscene_nail = true
	sun_anim.play("Sun")
	shader_anim.play("Finish")
	sun_anim.animation_finished.connect(sun_done)
	character.nail.anim.play("Sun")
	finish_blocker.set_collision_layer_value(1, true)
	start_time = float(Time.get_ticks_msec()) / 1000.0

func sun_done(something):
	character.final_anim.play("hide")
	final_spook_anim.play("Object_4Action")
	final_spook_anim.animation_finished.connect(finish)
	final_spook.call_deferred("show")
	final_noise.play()

func finish(something):
	main_scene.show_credits()
