extends Node3D

@onready var warning = $Warning
@onready var death = $Death

func disable():
	warning.call_deferred("set_monitoring", false)
	death.call_deferred("set_monitoring", false)
