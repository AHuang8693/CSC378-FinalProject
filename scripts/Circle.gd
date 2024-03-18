extends Node2D


#@onready var radius = $Area2D/CollisionShape2D.shape.radius # only copies the radius value, doesn't reference
@onready var circleShape = $Area2D/CollisionShape2D.shape # same as assigning inside _ready() function
@onready var circleSprite = $Sprite2D
@onready var bulletIn = false;

func start(_position, _direction):
	position = _position
	rotation = _direction
	$Area2D/CollisionShape2D.shape.radius = 10
	#this can't be circleShape for some reason

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(circleShape.radius < 200):
		circleShape.radius += 1.2
		circleSprite.scale += Vector2(0.012, 0.012)
	#$Area2D/CollisionShape2D.shape.radius += 1

func _on_area_2d_body_entered(body):
	if "Bullet" in body.name:
		bulletIn = true

func _on_area_2d_body_exited(body):
	if "Bullet" in body.name:
		bulletIn = false
