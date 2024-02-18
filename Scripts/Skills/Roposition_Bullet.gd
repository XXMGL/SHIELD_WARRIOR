extends Node

var levelNum = 0
var Bulllet_ac = [1,1.5,3]

func activate():
	levelNum = 1
	#levelNum += 1
	Character.Reposition_enabled = true
	pass
	
func deactivate():
	Character.Reposition_enabled = false
	pass

