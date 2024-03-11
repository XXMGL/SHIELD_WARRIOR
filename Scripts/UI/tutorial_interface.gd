extends CanvasLayer

@onready var close_Button = $"TutorialImage/Close button"


func _on_close_button_button_down():
	var lv_up_window = get_tree().get_first_node_in_group("Level_up")
	if lv_up_window == null:
		get_tree().paused = false
	queue_free()
	
func _Load_Totorial_img(key:String):
	var img = load("res://ART Assets/Tutorials/"+key+".png")
	var Tutorial_Image = $TutorialImage/img
	Tutorial_Image.texture = img
