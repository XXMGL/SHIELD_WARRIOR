extends Node2D
 
var group_name : String
var Enemy
 
var positions : Array 
var temp_positions : Array
var current_position : Marker2D
 
var direction : Vector2 = Vector2.ZERO
 
func _ready():
	Enemy = get_parent()
	if Enemy != null:
		group_name = Enemy.group_name
	#Character.connect("Route_Change",Callable(self,"_On_Route_Changed"))
	positions = get_tree().get_nodes_in_group(group_name)
	_get_positions()
	_get_next_position()
 
func _physics_process(_delta):
	if global_position.distance_to(current_position.position) < 10:
		_get_next_position()
 
func _get_positions():
	temp_positions = positions.duplicate()
	# temp_positions.shuffle()
 
func _get_next_position():
	if temp_positions.is_empty():
		_get_positions()
	current_position = temp_positions.pop_front()
	#direction = to_local(current_position.position).normalized()
	#print("current_position: ",current_position, "  Direction : ", direction)
	direction = (current_position.position - global_position).normalized()
	
func _On_Route_Changed():
	#print("route changed")
	group_name = Enemy.group_name
	pass
