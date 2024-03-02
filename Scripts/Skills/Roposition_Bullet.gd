extends Node

var levelNum = 0
var Bulllet_ac = [1,1.5,3]
var Name = "Reposition"


func activate():
	#levelNum = 1
	if levelNum < Bulllet_ac.size() - 1:
		levelNum += 1
	Character.Reposition_enabled = true
	Character.R_Bullet_ac = Bulllet_ac[levelNum - 1]
	#Character.bullet_1_tscn = load("res://TSCN/Bullet/bullet_R_1_reposition.tscn")
	#Character.bullet_1s_tscn = load("res://TSCN/Bullet/bullet_R_1s_Reposition.tscn")
	pass
	
func deactivate():
	Character.Reposition_enabled = false
	pass

