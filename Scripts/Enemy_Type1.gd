extends CharacterBody2D


var player
@export var move_speed = 100  # 在x方向的移动速度
var approach_speed = 50  # 在y轴上向玩家靠近的速度
@export var min_x_range = -200  # x方向的最小范围
@export var max_x_range = 200  # x方向的最大范围
@export var player_root = "玩家路径" # 玩家路径
var player_position
var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity
var timer = 0.0

func _ready():

	player = get_parent().get_node(player_root)  # 请将路径替换为玩家节点的路径


func _process(delta):
	 # 获取玩家的位置
	if player != null :
		player_position = player.global_position
		# 在y轴上向玩家靠拢
		# 根据玩家位置决定向上还是向下移动
		if player_position.y > global_position.y:
			y_direction = 1
		else:
			y_direction = -1
	else:
		y_direction = randf_range(-1, 1)  # 随机选择 -1、0、1
		pass
	
	# 在x方向上获得随即方向,每0.5秒随机获得方向
	timer += delta
	if timer >= 0.5:
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
