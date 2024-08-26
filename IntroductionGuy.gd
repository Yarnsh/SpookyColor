extends StaticBody3D

var character
var interacting = false
var textbox = 0
var text_list = [
	"You have made it my child",
	"This is it, inside lies your destiny",
	"Go forth and do the good lord's work",
	"Bright light back to his beautiful creation"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character != null and interacting:
		var from = character.cam.quaternion
		var to = Basis.looking_at(global_position - character.cam.global_position).get_rotation_quaternion()
		var rate = 50
		character.cam.quaternion = from.slerp(to, (rate * delta)*(rate * delta))
		
		from = quaternion
		quaternion = from.slerp(to, (rate * delta)*(rate * delta))
		global_rotation = Vector3(0.0, global_rotation.y, 0.0)

func interact(c):
	character = c
	if !interacting:
		character.state = character.CUTSCENE_STATE
		interacting = true
		
		character.cam.set_subtitles(text_list[textbox])
		textbox += 1
	else:
		if textbox >= text_list.size():
			character.state = character.NORMAL_STATE
			interacting = false
			set_collision_layer_value(2, false)
		else:
			character.cam.set_subtitles(text_list[textbox])
			textbox += 1
