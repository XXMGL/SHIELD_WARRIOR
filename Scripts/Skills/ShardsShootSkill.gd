extends Node


func activate():
	Character.Shards_Shoot_enabled = true
	#player.Shards_Shoot_enabled = true
	pass
	
func deactivate():
	Character.Shards_Shoot_enabled = false
	pass

