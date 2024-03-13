extends Node2D
 
var group_name : String
var object
var Powerup
 
var positions : Array 
var temp_positions : Array
var current_position : Marker2D
 
var direction : Vector2 = Vector2.ZERO

var disable_Wander = false
 
func _ready():
	LevelManager.connect("Final_Enemy_Die",Callable(self,"_Set_Disable"))
	object = get_parent()
	if object != null:
		group_name = object.group_name
	
	Character.connect("Route_Change",Callable(self,"_On_Route_Changed"))
	positions = get_tree().get_nodes_in_group(group_name)
	_get_positions()
	_get_next_position()
 
func _physics_process(_delta):
	if disable_Wander == false:
		if global_position.distance_to(current_position.position) < 10:
			_get_next_position()
 
func _get_positions():
	temp_positions = positions.duplicate()
	# temp_positions.shuffle()
 
func _get_next_position():
	if temp_positions.is_empty():
		_get_positions()
	current_position = temp_positions.pop_front()
	direction = (current_position.position - global_position).normalized()
	
func _On_Route_Changed(newRoute):
	#print("route changed")
	group_name = object.group_name
	positions = get_tree().get_nodes_in_group(newRoute)
	pass
	
func _Set_Disable():
	disable_Wander = true
