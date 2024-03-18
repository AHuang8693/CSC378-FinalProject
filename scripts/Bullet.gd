extends CharacterBody2D

const SPEED = 200


# Called when the node enters the scene tree for the first time.
#func _ready():
	#set_velocity(motion)
	
func start(_position, _direction):
	position = _position
	rotation = _direction
	velocity = Vector2(SPEED, 0).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
