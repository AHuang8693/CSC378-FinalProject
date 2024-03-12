extends CharacterBody2D

var movespeed = 200

#func _ready():
	#pass

func read_input():
	var motion = Vector2()
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	velocity = motion.normalized() * movespeed
	move_and_slide()
	
func _physics_process(delta):
	read_input()
	look_at(get_global_mouse_position())
	
