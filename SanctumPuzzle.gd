extends Node3D

@onready var death = $Death
@onready var warning = $Warning

func enable():
	show()
	death.set_deferred("monitoring", true)
	warning.set_deferred("monitoring", true)

func disable():
	hide()
	death.set_deferred("monitoring", false)
	warning.set_deferred("monitoring", false)
