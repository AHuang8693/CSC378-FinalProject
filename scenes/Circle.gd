extends Node2D


#@onready var radius = $Area2D/CollisionShape2D.shape.radius # only copies the radius value, doesn't reference
@onready var circleShape = $Area2D/CollisionShape2D.shape # same as assigning inside _ready() function

	
func start(_position, _direction):
	position = _position
	rotation = _direction
	$Area2D/CollisionShape2D.shape.radius = 10
	#this can't be circleShape for some reason
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(circleShape.radius < 200):
		circleShape.radius += 1.2
	#$Area2D/CollisionShape2D.shape.radius += 1
	
