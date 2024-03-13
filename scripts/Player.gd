extends CharacterBody2D

const MOVESPEED = 500
const BULLET_SPEED = 1000
var bullet = preload("res://Bullet.tscn")

#func _ready():
	#pass
	
func _physics_process(delta):
	read_input()
	look_at(get_global_mouse_position())

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
	velocity = motion.normalized() * MOVESPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("LMB"):
		fire()
	
func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position  = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(BULLET_SPEED,0).rotated(global_rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
func kill():
	get_tree().reload_current_scene() #reloads the game

func _on_area_2d_body_entered(body):
	if "Enemy" in body.name:
		kill()
