extends CharacterBody2D

var cur_dir = Vector2(1,0)
var directions = []
var pos_array = []

var move_speed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print_debug(directions.size())
	print_debug(pos_array.size())
	
	if (directions.size() > 0):
		if (position == pos_array[0]):
			cur_dir = directions[0]
			remove_move_dir_from_tail()
			
	print_debug(cur_dir)		
	velocity = cur_dir * move_speed
	
	move_and_slide()
	
func remove_move_dir_from_tail():
	directions.pop_front()
	pos_array.pop_front()
	
func add_move_dir_to_tail(head_pos, dir):
	directions.append(dir)
	pos_array.append(head_pos)

