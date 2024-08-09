extends Light3D

var wait = 2
var mask

func _ready():
	mask = get_cull_mask()
	set_cull_mask(0xFFFFFFFF)

func _process(delta):
	if wait > 0:
		wait -= 1;
	else:
		set_cull_mask(mask)
		set_process(false)
