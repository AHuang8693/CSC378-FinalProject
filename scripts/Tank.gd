extends CharacterBody2D

const MOVE_SCALE = 70 # smaller means the enemy is faster
const SPEED = 60
@onready var animations = $AnimationPlayer
@export var player : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var hp = 3

func updateAnimation():
	animations.play("tank_run")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var Player = get_parent().get_node("Player")
	global_rotation = 0
	if self.position.x > Player.position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _physics_process(_delta: float):
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
		hp -= 1
		if(hp == 0):
			queue_free() #deletes enemy; queues the entire node to be freed by the end of the frame
