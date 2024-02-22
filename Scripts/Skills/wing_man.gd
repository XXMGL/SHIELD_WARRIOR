extends CharacterBody2D
# 目标对象
var target: Node2D
# 旋转半径
@export var radius: float = 100
# 移动速度
@export var move_speed: float = 100
# 当前角度
@export var WM_Num = 0
var current_angle: float = 0

var levelNum = 0

var AimTarget: Node2D

var BulletPrefab = preload("res://TSCN/Bullet/bullet_R_1.tscn")

func _ready():
	target = get_parent()
	pass

func _physics_process(delta):
	if target:
		# 每帧增加一个角度
		current_angle += move_speed * delta
		# 将角度限制在0到360度之间
		current_angle = int(current_angle) % 360
		
		# 计算目标位置
		var target_position = target.global_position
		
		# 计算新位置
		var new_x = target_position.x + cos(deg_to_rad(current_angle)+WM_Num*120) * radius
		var new_y = target_position.y + sin(deg_to_rad(current_angle)+WM_Num*120) * radius
		
		# 移动到新位置
		global_position = Vector2(new_x, new_y)
	pass

func activate():
	levelNum = 1
	#levelNum += 1
	

	
	#player.Shards_Shoot_enabled = true
	pass
	
func deactivate():
	pass
	
func ShootBullet_WM():
	var bullet = BulletPrefab.instantiate()
	#get_parent().add_child(bullet)
	get_parent().get_parent().call_deferred("add_child", bullet)
	bullet.position = $BulletSpawner.global_position
	if Character.Target_Enemy != null:
		#bullet.MoveDirection = (Character.Target_Enemy.global_position - $BulletSpawner.global_position).normalized()
		bullet.MoveDirection = Character.IndicatorDirection
		#bullet.MoveDirection = Vector2(1,0)
	else:
		bullet.MoveDirection = Vector2(1,0)
		pass
	#print_debug(bullet.MoveDirection)
	pass
	
func _CharacterDetection():
	# 目前只用作碰撞检测时识别node
	pass


func _on_bullet_spawner_body_entered(body):
	if body.has_method("_BulletDetection"):
		#print_debug("11")
		ShootBullet_WM()
		pass
	pass # Replace with function body.
