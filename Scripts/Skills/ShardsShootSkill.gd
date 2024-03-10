extends Node

var levelNum = 0
var MaxLevel = 3
var ShardsNum = [3,5,9]
var Name = "Shards Shoot"
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 1
var branch_size:int = 1
#skill at full level wont appear in the skill pool

func activate():
	#levelNum = 1
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	Character.Shards_Shoot_enabled = true
	Character.Shards_Acount = ShardsNum[levelNum -1]
	
	#player.Shards_Shoot_enabled = true
	pass
	
func deactivate():
	Character.Shards_Shoot_enabled = false
	pass

