extends Node

var levelNum = 0
var Hearts_Num = [3,4,4]
var Name = "Resilient Heart"
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
#skill at full level wont appear in the skill pool

func activate():
	#levelNum = 1
	if levelNum < Hearts_Num.size() - 1:
		levelNum += 1
	if levelNum >= Hearts_Num.size() - 1:
		isFullLv = true
	Character.HealthBar.visible = false
	Character.HeartNum = Hearts_Num[levelNum-1]
	Character._R_Heart()
		
	pass
	
func deactivate():

	pass
