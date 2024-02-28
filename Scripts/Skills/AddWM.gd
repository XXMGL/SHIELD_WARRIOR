extends Node

var levelNum = 0
var Bulllet_ac = [1,2,3]
var Name = "Wing Man"
var WingMan_tscn = preload("res://TSCN/Player/Skills/wing_man.tscn")


func activate():
	var newWM = WingMan_tscn.instantiate()
	var Player = get_tree().get_first_node_in_group("Player")
	Player.add_child(newWM)
	#print_debug(newWM.get_parent())
	levelNum = 1
	#levelNum += 1
	#newWM.target = get_parent()
	newWM.WM_Num = levelNum
	pass
	
func deactivate():
	pass
