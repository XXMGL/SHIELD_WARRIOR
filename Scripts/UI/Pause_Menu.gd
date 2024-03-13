extends CanvasLayer


var NextScene:String

# Called when the node enters the scene tree for the first time.
func _ready():
	var levelScript = get_tree().get_nodes_in_group("Level")
	NextScene = levelScript[0].Level_Path
	print_debug(NextScene)
	pass # Replace with function body.





func _on_resume_pressed():
	# 恢复游戏中的各种活动
	var UI = get_tree().get_first_node_in_group("UI")
	UI.resume_game()
	#get_tree().paused = false
	


func _on_next_level_pressed():
	var UI = get_tree().get_first_node_in_group("UI")
	UI.resume_game()
	var Level = get_tree().get_first_node_in_group("Level")
	#print_debug(Level)
	Level.load_next_level()
	pass # Replace with function body.
	
func load_next_level():
	
	get_tree().change_scene_to_file(NextScene)
