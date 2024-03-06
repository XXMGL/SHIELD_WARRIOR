extends Node

var levelNum = 0
var WM_Lv = [1,2,3]
var Name = "Wing Man"
var WingMan_tscn = preload("res://TSCN/Player/Skills/wing_man.tscn")
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 0
#skill at full level wont appear in the skill pool

func activate():
	if levelNum < WM_Lv.size() :
		levelNum += 1
	if levelNum >= WM_Lv.size() :
		isFullLv = true
	if levelNum == 1:
		var newWM = WingMan_tscn.instantiate()
		var Player = get_tree().get_first_node_in_group("Player")
		Player.add_child(newWM)
	elif levelNum == 2:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv2 = true
	elif levelNum == 3:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv3 = true
	#print_debug(levelNum)

	pass
	
func deactivate():
	pass
