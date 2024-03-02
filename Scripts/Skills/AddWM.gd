extends Node

var levelNum = 0
var WM_Lv = [1,2,3]
var Name = "Wing Man"
var WingMan_tscn = preload("res://TSCN/Player/Skills/wing_man.tscn")


func activate():
	if levelNum < WM_Lv.size() - 1:
		levelNum += 1
	if WM_Lv[levelNum - 1] == 1:
		var newWM = WingMan_tscn.instantiate()
		var Player = get_tree().get_first_node_in_group("Player")
		Player.add_child(newWM)
	elif WM_Lv[levelNum - 1] == 2:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv2 = true
	elif WM_Lv[levelNum - 1] == 3:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv3 = true

	pass
	
func deactivate():
	pass
