extends Node

var levelNum = 0
var Lv_up = [1,1.5,3]
var Name = "Resilient Heart"


func activate():
	levelNum = 1
	#levelNum += 1
	Character.HealthBar.visible = false
	Character._R_Heart()
	pass
	
func deactivate():

	pass
