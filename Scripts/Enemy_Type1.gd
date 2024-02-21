extends CharacterBody2D

@export var move_speed = 100  # 在x方向的移动速度
@export var approach_speed = 50  # 在y轴上向玩家靠近的速度
@export var player_root = "玩家路径" # 玩家路径
@onready var EnemyAnimation = $AnimationPlayer
var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity
var timer = 0.0

var bullet_tscn = preload("res://TSCN/Bullet/bullet_1.tscn")
@export var ShootDuration = 2.0
var Shoot_timer = 0.0

var Health = 10


func _ready():
	pass


func _process(delta):
	EnemyAnimation.play("idle")
	Shoot_timer += delta
	if Shoot_timer >= ShootDuration:
		_ShootBullet()
		Shoot_timer = 0
	else:
		pass
	
	_FoundTarget(player_root)		
	# 在x方向上获得随即方向,每0.5秒随机获得方向
	timer += delta
	if timer >= 0.5:
		_ShootBullet()
		x_direction = randf_range(-1, 1)  # 随机选择 -1、0、1
		timer = 0
	x_velocity = x_direction * move_speed
	
	# 限制x轴移动范围
	#global_position.x = global_position.x + x_velocity

	y_velocity = y_direction * approach_speed
	
	# 更新y轴位置
	#global_position.y += y_velocity
	velocity = Vector2(x_velocity,y_velocity)	
	move_and_slide()	
	
	if Health <= 0:
		queue_free()  # 销毁
	
func _FoundTarget(TargetPath):
	var target = get_parent().get_node(TargetPath)
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

func _ShootBullet():
	var bullet = bullet_tscn.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawner.global_position
	
func _EnemyDetection():
	pass


func _on_bullet_spawner_body_entered(body):
	pass


	
