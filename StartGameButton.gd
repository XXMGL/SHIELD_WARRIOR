extends Button


func _on_pressed():
	Bgm.emit_signal("ButtonClick")
	LevelManager.emit_signal("Start_Game")
	Load_First_Scene()
	Character._Rebirth()
	pass # Replace with function body.



func Load_First_Scene():
	
	#get_tree().change_scene_to_file("res://TSCN/Scene/default_scene.tscn")
	get_tree().change_scene_to_packed(load("res://TSCN/Scene/default_scene.tscn"))
