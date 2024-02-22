extends CharacterBody2D

enum PowerupType {recover_life_value, raise_stamina_limit, increase_movement_speed}
@export var powerup_type = PowerupType.recover_life_value

@export var wander_direction : Node2D
@export var group_name : String

func _ready():
	pass


func _physics_process(delta):
	pass
	


func _on_detector_body_entered(body):
	if body.has_method("_CharacterDetection"):
		ActivePowerupFunc(body)
		queue_free()

func ActivePowerupFunc(body):
	pass
