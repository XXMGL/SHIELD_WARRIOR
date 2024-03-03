extends Node

var levelNum = 0
var ShardsNum = [3,5,9]
var Name = "Shards Shoot"
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
#skill at full level wont appear in the skill pool

func activate():
	#levelNum = 1
	if levelNum < ShardsNum.size() - 1:
		levelNum += 1
	if levelNum >= ShardsNum.size() - 1:
		isFullLv = true
	Character.Shards_Shoot_enabled = true
	Character.Shards_Acount = ShardsNum[levelNum -1]
	
	#player.Shards_Shoot_enabled = true
	pass
	
func deactivate():
	Character.Shards_Shoot_enabled = false
	pass

