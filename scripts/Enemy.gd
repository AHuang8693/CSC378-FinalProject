extends CharacterBody2D

const MOVE_SCALE = 70 # smaller means the enemy is faster
const SPEED = 100
var motion = Vector2()

@export var player : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float):
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * SPEED
	move_and_slide()
	
	#position += (Player.position - position) / MOVE_SCALE 
	#look_at(Player.position)
	#move_and_collide(motion)

func makePath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	makePath()

func _on_area_2d_body_entered(body):
	if "Bullet" in body.name:
		queue_free() #deletes enemy; queues the entire node to be freed by the end of the frame
