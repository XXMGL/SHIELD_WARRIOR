extends CharacterBody2D

var move_speed = 100

@export var move_direction = Node2D

var group_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = move_direction.direction * move_speed
	
	move_and_slide()
	


