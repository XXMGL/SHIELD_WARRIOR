extends Node2D

@export var move_direction = Node2D
@export var move_speed = 100
@export var tails = []

@export var group_name : String
@export var ShootDuration = 2.0

@export var MaxHealth = 1000

var prev_dir = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	
func move():
	var head_pos = get_node("Head").position
	get_node("Head").velocity = move_direction.direction * move_speed
	
	var dir_change = false
	if (prev_dir != move_direction.direction):
		prev_dir = move_direction.direction
		dir_change = true
	if (dir_change == true):
		for i in tails:
			get_node(i).add_move_dir_to_tail(head_pos, move_direction.direction)
	
