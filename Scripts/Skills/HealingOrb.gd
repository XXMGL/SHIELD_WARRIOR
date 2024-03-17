extends CharacterBody2D




func _on_area_2d_body_entered(body):
	if body.has_method("_CharacterDetection"):
		Character.health += 20
		Character.emit_signal("heal")
		queue_free()
	pass # Replace with function body.
