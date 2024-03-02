extends Node

var levelNum = 0
var Hearts_Num = [3,4,4]
var Name = "Resilient Heart"


func activate():
	#levelNum = 1
	if levelNum < Hearts_Num.size() - 1:
		levelNum += 1
	Character.HealthBar.visible = false
	Character.HeartNum = Hearts_Num[levelNum-1]
	Character._R_Heart()
		
	pass
	
func deactivate():

	pass
