extends CharacterBody2D

const MOVE_SCALE = 50 # smaller means the enemy is faster
var motion = Vector2()

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	position += (Player.position - position) / MOVE_SCALE 
	
	move_and_collide(motion)
