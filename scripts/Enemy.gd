extends CharacterBody2D

const MOVE_SCALE = 70 # smaller means the enemy is faster
var motion = Vector2()

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	position += (Player.position - position) / MOVE_SCALE 
	look_at(Player.position)
	
	move_and_collide(motion)


func _on_area_2d_body_entered(body):
	if "Bullet" in body.name:
		queue_free() #deletes enemy; queues the entire node to be freed by the end of the frame
