extends Node3D

var base_y = -2.128 # too lazy to move everything to 0 at this point
@onready var s1 = $Statues1
@onready var s2 = $Statues2
@onready var s3 = $Statues3

func _ready():
	set_state(1)

func set_state(state):
	s1.position.y = -500
	s2.position.y = -500
	s3.position.y = -500
	
	if state == 1:
		s1.position.y = base_y
	elif state == 2:
		s2.position.y = base_y
	elif state == 3:
		s3.position.y = base_y
