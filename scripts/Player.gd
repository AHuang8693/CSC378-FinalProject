extends CharacterBody2D

const MOVESPEED = 500
const BULLET_SPEED = 1000
var bullet = preload("res://scenes/Bullet.tscn")

var hasBullet = true;

var anim = "idle"
var shoot_animation_completed = true
@onready var animations = $AnimationPlayer


#func _ready():	
	#pass
	
func _physics_process(delta):
	read_input()
	look_at(get_global_mouse_position())
	updateAnimation()
	on_AnimatedSprite_animation_finished()

func read_input():
	var motion = Vector2()
	var new_anim = anim
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
		
	if Input.is_action_just_pressed("LMB") and shoot_animation_completed == true:
		new_anim = "shoot"
		fire()
	
	if new_anim != anim and shoot_animation_completed == true:
		anim = new_anim
		animations.play(anim)
		if anim == "shoot":
			shoot_animation_completed = false
		
	velocity = motion.normalized() * MOVESPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("LMB"):
		if hasBullet:
			fire()
			hasBullet = false
		else:
			pass #play no ammo indicator sound here?

func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "right"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		
		animations.play("walk_" + direction)
	
func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.start(get_global_position(), rotation)
	#bullet_instance.position  = get_global_position()
	#bullet_instance.rotation_degrees = rotation_degrees
	add_sibling(bullet_instance)
	#bullet_instance.apply_impulse(Vector2(BULLET_SPEED,0).rotated(global_rotation))
	#get_tree().get_root().call_deferred("add_child", bullet_instance)
	
func kill():
	get_tree().reload_current_scene() #reloads the game

func _on_area_2d_body_entered(body):
	if "Enemy" in body.name:
		kill()
		
func on_AnimatedSprite_animation_finished():
	if anim == "shoot":
		shoot_animation_completed = true
