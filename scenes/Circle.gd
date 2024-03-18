extends Node2D


#@onready var radius = $Area2D/CollisionShape2D.shape.radius
@onready var circleShape = $Area2D/CollisionShape2D.shape


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func start(_position, _direction):
	position = _position
	rotation = _direction
	$Area2D/CollisionShape2D.shape.radius = 10
	#this can't be circleShape for some reason
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(circleShape.radius < 200):
		circleShape.radius += 1.2
	#$Area2D/CollisionShape2D.shape.radius += 1
	
