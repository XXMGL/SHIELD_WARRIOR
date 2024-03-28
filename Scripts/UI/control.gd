extends CanvasLayer




func _on_close_button_pressed():
	queue_free()
	pass # Replace with function body.


func _on_button_pressed():
	var Assets = $Panel/TutorialImage2
	var Credit = $Panel/TutorialImage
	Credit.visible = false
	Assets.visible = true
	pass # Replace with function body.
