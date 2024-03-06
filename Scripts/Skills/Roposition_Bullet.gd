extends Node

var levelNum = 0
var Bulllet_ac = [1,1.5,3]
var Name = "Reposition"
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 0
#skill at full level wont appear in the skill pool

func activate():
	#levelNum = 1
	if levelNum < Bulllet_ac.size() - 1:
		levelNum += 1
	if levelNum >= Bulllet_ac.size() - 1:
		isFullLv = true
	Character.Reposition_enabled = true
	Character.R_Bullet_ac = Bulllet_ac[levelNum - 1]
	#Character.bullet_1_tscn = load("res://TSCN/Bullet/bullet_R_1_reposition.tscn")
	#Character.bullet_1s_tscn = load("res://TSCN/Bullet/bullet_R_1s_Reposition.tscn")
	pass
	
func deactivate():
	Character.Reposition_enabled = false
	pass

