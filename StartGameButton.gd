extends Button


func _on_pressed():
	LevelManager.emit_signal("Start_Game")
	Load_First_Scene()
	pass # Replace with function body.



func Load_First_Scene():
	get_tree().change_scene_to_file("res://TSCN/Scene/default_scene.tscn")
