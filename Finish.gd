extends Area3D

@onready var main_scene = $"../../.."
@export var final_spook : Node
var final_spook_anim : AnimationPlayer
@export var finish_blocker : StaticBody3D
var character = null

func _ready():
	final_spook_anim = final_spook.get_node("AnimationPlayer")
	final_spook.hide()

func _process(delta):
	if character != null:
		# TODO: move more darkness into place to block view
		pass

func _on_body_entered(body):
	monitoring = false
	character = body
	final_spook_anim.play("Object_4Action")
	final_spook_anim.animation_finished.connect(finish)
	final_spook.show()
	finish_blocker.set_collision_layer_value(1, true)
	
	print("GAME OVER BABY")

func finish(something):
	main_scene.show_credits()
