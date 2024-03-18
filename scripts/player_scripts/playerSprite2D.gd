extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0  
	if get_global_mouse_position().x < get_parent().position.x:
		flip_h = true
	else:
		flip_h = false
