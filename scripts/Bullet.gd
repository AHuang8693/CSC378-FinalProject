extends CharacterBody2D

const SPEED = 200
@onready var animations = $AnimationPlayer
var bounce := AudioStreamPlayer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	bounce.stream = load("res://assets/audio/bounce.mp3")
	add_child(bounce)
	
func start(_position, _direction):
	position = _position
	rotation = _direction
	velocity = Vector2(SPEED, 0).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	updateAnimation()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		bounce.volume_db = -18
		bounce.play()
		velocity = velocity.bounce(collision_info.get_normal())

func updateAnimation():
	animations.play("bullet")
