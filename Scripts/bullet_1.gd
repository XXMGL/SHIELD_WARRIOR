extends CharacterBody2D

@export var player_root = "Character" # 玩家路径
@export var enemy_Root = "Enemy_Type1" #敌人路径

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity

@export var move_speed = 200  # 在x方向的移动速度
@export var approach_speed = 50  # 在y轴上向玩家靠近的速度

enum {From_Enemy, From_Player}
@export var Origin = From_Enemy

func _ready():
	pass
	
func _process(delta):
	match Origin:
		From_Enemy:
			_FoundTarget(player_root)
			x_direction = -1
			x_velocity = x_direction * move_speed
			y_velocity = y_direction * approach_speed
			velocity = Vector2(x_velocity,y_velocity)
			move_and_slide()	
			pass
		From_Player:
			pass
	
func _FoundTarget(TargetPath):
	var target = get_parent().get_node(TargetPath)
	if target != null:
		var target_position = target.global_position
		if target_position.y > global_position.y:
			y_direction = 1
		elif  target_position.y < global_position.y:
			y_direction = -1
		else:
			y_direction = 0
	else:
		pass
		



func _on_detector_body_entered(body):
	if body.has_method("get_name") and (body.get_name() == "Eage" or body.get_name() == "Character"):
		queue_free()  # 销毁子弹
	pass # Replace with function body.
