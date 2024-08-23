extends PanelContainer

@onready var credits = $Node/Credits
var moving = false

func _process(delta):
	if moving:
		credits.position.y -= 100.0 * delta
		
		if credits.position.y + credits.size.y <= 0.0: # TODO: this is getting us the wrong value somehow?
			get_tree().quit()

func start_credits():
	moving = true
	credits.position.y = get_tree().root.size.y

func _on_visibility_changed():
	credits.visible = visible
