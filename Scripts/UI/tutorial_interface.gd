extends CanvasLayer

@onready var Tutorial_Image = $"tutorial image"
@onready var close_Button = $"tutorial image/Close button"


func _on_close_button_button_down():
	var lv_up_window = get_tree().get_first_node_in_group("Level_up")
	if lv_up_window == null:
		get_tree().paused = false
	queue_free()
