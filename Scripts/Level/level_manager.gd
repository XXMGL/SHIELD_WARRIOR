extends Node

signal Final_Enemy_Die
signal Move_To_Next_Level
signal Move_In_Next_Level
signal Start_Game
signal End_Game

var Game_Time_s = 0
var Game_Time_m = 0
var Game_Time_h = 0
var Game_Time_s_str = "00"
var Game_Time_m_str = "00"
var Game_Time_h_str = "00"
var LevelNum = 0

func _ready():
	connect("Start_Game",Callable(self,"_Game_Start"))
	connect("End_Game",Callable(self,"_Game_End"))

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
	
	
	
func _Game_Start():
	Game_Time_s = 0 
	Game_Time_m = 0 
	var Game_Timer = $Timer
	Game_Timer.start()
	#Character.Level_Num_InCanvas = str(Character.LevelNum)
	
func _Game_End():
	var Game_Timer = $Timer
	Game_Timer.stop()


func _on_timer_timeout():
	Game_Time_s += 1
	if Game_Time_s < 10:
		Game_Time_s_str = "0"+str(Game_Time_s)
	else:
		Game_Time_s_str = str(Game_Time_s)
	if Game_Time_s>=60:
		Game_Time_m += 1
		Game_Time_s = 0
		if Game_Time_m < 10:
			Game_Time_m_str = "0"+str(Game_Time_m)
		else:
			Game_Time_m_str = str(Game_Time_m)
		if Game_Time_m>=60:
			Game_Time_h += 1
			Game_Time_m = 0
			if Game_Time_h < 10:
				Game_Time_h_str = "0"+str(Game_Time_h)
			else:
				Game_Time_h_str = str(Game_Time_h)
