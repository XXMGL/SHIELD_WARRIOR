extends CharacterBody2D

@export var player_root = "Character" # 玩家路径
@export var enemy_Root = "Enemy_Type1" #敌人路径

# @onready var BulletAnimation = $AnimationPlayer

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity

@export var move_speed = 200  # 在x方向的移动速度
@export var approach_speed = 50  # 在y轴上向玩家靠近的速度

enum Origin{From_Enemy, From_Player}
@export var OriginFrom = Origin.From_Enemy

@export var Damage = 10

func _ready():
	pass
	
func _process(_delta):
	match OriginFrom:
		Origin.From_Enemy:
			# BulletAnimation.play("shoot")
			_FoundTarget()
			x_direction = -1
			x_velocity = x_direction * move_speed
			y_velocity = y_direction * approach_speed
			velocity = Vector2(x_velocity,y_velocity)
			move_and_slide()	
			pass
		Origin.From_Player:
			pass
	
func _FoundTarget():
	var target = get_tree().get_first_node_in_group("Player")
	if target != null:
		var target_position = target.global_position
		if target_position.y > global_position.y:
			y_direction = 1
		elif  target_position.y < global_position.y:
			y_direction = -1
		else:
			y_direction = randf_range(-1, 1)  # 随机选择 -1、0、1
	else:
		pass
		



func _on_detector_body_entered(body):
	if body.has_method("get_name") and body.get_name() == "Eage":
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_CharacterDetection"):
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_WingManDetection"):
		queue_free() # 销毁
	if OriginFrom == Origin.From_Player and body.has_method("_EnemyDetection"):
		queue_free()  # 销毁子弹
		
func _BulletDetection():
	return Damage
