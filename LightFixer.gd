extends Light3D

var wait = 2
var mask

# Called when the node enters the scene tree for the first time.
func _ready():
	mask = get_cull_mask()
	set_cull_mask(0xFFFFFFFF)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wait > 0:
		wait -= 1;
	else:
		set_cull_mask(mask)
		set_process(false)
