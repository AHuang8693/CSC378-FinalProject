extends CharacterBody2D

const MOVESPEED = 300
const BULLET_SPEED = 1000
var bullet = preload("res://scenes/Bullet.tscn")
var bullet_instance
var circle = preload("res://scenes/Circle.tscn")
var circle_instance
var anim = "idle"
var bg_music := AudioStreamPlayer.new()
var charge := AudioStreamPlayer.new()
var shoot := AudioStreamPlayer.new()
@onready var animations = $AnimationPlayer

func _ready():
	bg_music.stream = load("res://assets/audio/bgm.mp3")
	bg_music.autoplay = true
	bg_music.volume_db = -20
	add_child(bg_music)
	add_child(charge)
	add_child(shoot)
	bg_music.play(Audio.musicProgress)   

func _physics_process(_delta):
	read_input()
	look_at(get_global_mouse_position())
	updateAnimation()
	_on_animation_player_animation_finished(anim)

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
	
	#can't shoot if charging up catch circle
	if Input.is_action_just_pressed("LMB") and !Input.is_action_pressed("space"):
		if(bullet_instance == null):
			anim = "shoot"
			shoot.stream = load("res://assets/audio/shoot.mp3")
			shoot.volume_db = -5
			shoot.play()
			fire()
		else:
			pass # some sort of no ammo indicator here -----
	
	#charge up catch circle
	if Input.is_action_just_pressed("ui_accept"):
		charge.stream = load("res://assets/audio/charge.mp3")
		charge.volume_db = -10
		charge.play()

	if Input.is_action_pressed("space"):
		motion.x = 0	#imobolize the player
		motion.y = 0
		if(circle_instance == null):
			circle_instance = circle.instantiate()
			circle_instance.start(self.position, 0)
			add_sibling(circle_instance)
	
	if Input.is_action_just_released("space"):
		charge.stop()
		if(circle_instance != null):
			#if bullet is in circle and exists
			if(circle_instance.bulletIn and bullet_instance != null):
				bullet_instance.queue_free() # remove bullet
			circle_instance.queue_free() # finally, remove circle 
		
	velocity = motion.normalized() * MOVESPEED
	move_and_slide()


func updateAnimation():
	if anim == "shoot":
		animations.play("shoot")
	else:
		if velocity.length() == 0:
			animations.play("idle")
		else:
			animations.play("walk_right")
	
func fire():
	bullet_instance = bullet.instantiate()
	
	bullet_instance.start(self.position, rotation)
	add_sibling(bullet_instance)
	
func kill():
	Audio.musicProgress = bg_music.get_playback_position()  
	get_tree().reload_current_scene() #reloads the game

func _on_area_2d_body_entered(body):
	if "Droid" in body.name or "Tank" in body.name:
		kill()
		

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot":
		anim = "idle"
