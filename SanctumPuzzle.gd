extends Node3D

@onready var death = $Death

func enable():
	show()
	death.set_deferred("monitoring", true)

func disable():
	hide()
	death.set_deferred("monitoring", false)
