extends CharacterBody2D

const MOVE_SCALE = 70 # smaller means the enemy is faster
const SPEED = 90
@onready var animations = $AnimationPlayer
@export var player : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var anim = "idle"
	

func updateAnimation():
	if anim == "death":
		animations.play("death")
	else:
		animations.play("run")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateAnimation()
	var Player = get_parent().get_node("Player")
	global_rotation = 0
	if self.position.x > Player.position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false


func _physics_process(_delta: float):
	if anim == "death":
		velocity = Vector2.ZERO
	else:
		var next_path_pos := nav_agent.get_next_path_position()
		var dir := global_position.direction_to(next_path_pos)
		velocity = dir * SPEED
	#look_at(next_path_pos)
	move_and_slide()
	updateAnimation()
	

func makePath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	makePath()

func _on_area_2d_body_entered(body):
	if "Bullet" in body.name:
		anim = "death"
		

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free() #deletes enemy; queues the entire node to be freed by the end of the frame
