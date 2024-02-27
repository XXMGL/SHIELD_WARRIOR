extends CharacterBody2D

var cur_dir = Vector2(0,0)
var directions = []
var pos_array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = cur_dir * get_parent().move_speed
	if (directions.size() > 0):
		if (position == pos_array[0]):
			cur_dir = directions[0]
			remove_move_dir_from_tail()
	
func remove_move_dir_from_tail():
	directions.pop_front()
	pos_array.pop_front()
	
func add_move_dir_to_tail(head_pos, dir):
	directions.append(head_pos)
	pos_array.append(dir)
