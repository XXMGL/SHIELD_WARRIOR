extends Node

var levelNum = 0
var ShardsNum = [3,5,9]
var Name = "Shards Shoot"

func activate():
	levelNum = 1
	#levelNum += 1
	Character.Shards_Shoot_enabled = true
	Character.Shards_Acount = ShardsNum[levelNum]
	
	#player.Shards_Shoot_enabled = true
	pass
	
func deactivate():
	Character.Shards_Shoot_enabled = false
	pass

