extends CharacterBody2D

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity

@export var move_speed = 200  # 在x方向的移动速度

enum {From_Enemy, From_Player}
@export var Origin = From_Enemy

func _ready():
	pass
	
func _process(delta):
	match Origin:
		From_Enemy:
			x_direction = -1
			x_velocity = x_direction * move_speed
			velocity = Vector2(x_velocity,0)
			move_and_slide()	
			pass
		From_Player:
			pass


func _on_detector_body_entered(body):
	if body.has_method("get_name") and (body.get_name() == "Eage" or body.get_name() == "Character"):
		queue_free()  # 销毁子弹
	pass # Replace with function body.
