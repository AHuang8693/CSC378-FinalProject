extends CharacterBody2D

const MOVE_SCALE = 70 # smaller means the enemy is faster
var motion = Vector2()
@onready var animations = $AnimationPlayer

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	position += (Player.position - position) / MOVE_SCALE 
	look_at(Player.position)
	updateAnimation()
	move_and_collide(motion)
	

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

func _on_area_2d_body_entered(body):
	if "Bullet" in body.name:
		queue_free() #deletes enemy; queues the entire node to be freed by the end of the frame
