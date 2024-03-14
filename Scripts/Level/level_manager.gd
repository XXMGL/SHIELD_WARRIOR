extends Node

signal Final_Enemy_Die
signal Move_To_Next_Level
signal Move_In_Next_Level

var LevelNum = 0

func Level_up_Interface(L_Weight,B_Weight,G_Weight):
	var Level_Up_Window_prefab = load("res://TSCN/UI/level_up.tscn")
	var Level_Up_Window = Level_Up_Window_prefab.instantiate()
	#设置技能稀有度权重
	Level_Up_Window.skills_L_weight = L_Weight
	Level_Up_Window.skills_B_weight = B_Weight
	Level_Up_Window.skills_G_weight = G_Weight
	add_child(Level_Up_Window)
	# 禁用游戏中的各种活动
	get_tree().paused = true
	
	
	
