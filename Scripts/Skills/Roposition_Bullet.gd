extends Node

var levelNum = 0
var Bulllet_ac = [1,1.5,3]
var Name = "Reposition"


func activate():
	levelNum = 1
	#levelNum += 1
	Character.Reposition_enabled = true
	Character.bullet_1_tscn = load("res://TSCN/Bullet/bullet_R_1_reposition.tscn")
	Character.bullet_1s_tscn = load("res://TSCN/Bullet/bullet_R_1s_Reposition.tscn")
	pass
	
func deactivate():
	Character.Reposition_enabled = false
	pass

