extends CharacterBody2D
@onready var Animator = $AnimatedSprite2D

func _ready():
	Animator.play("default")

func _on_area_2d_body_entered(body):
	if body.has_method("_CharacterDetection"):
		Character.health += 20
		Character.emit_signal("heal")
		CharacterData.emit_signal("Pick_Up_Item")
		queue_free()
	pass # Replace with function body.
