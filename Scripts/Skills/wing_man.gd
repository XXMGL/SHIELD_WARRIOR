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

var Name = "Wing Man"

@export var isLv2 = false
@export var isLv3 = false

func _ready():
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))
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

	
func deactivate():
	queue_free()
	pass
	
func ShootBullet_WM():
	var newBulletPrefab
	if isLv3 == true:
		newBulletPrefab = Character.bullet_prefab
	else:
		newBulletPrefab = BulletPrefab
	var bullet = newBulletPrefab.instantiate()
	#get_parent().add_child(bullet)
	get_parent().get_parent().call_deferred("add_child", bullet)
	bullet.position = $BulletSpawner.global_position
	_Do_Reposition(bullet)
	bullet.MoveDirection = Character.IndicatorDirection

	
func _WingManDetection():
	# 目前只用作碰撞检测时识别node
	pass


func _on_bullet_spawner_body_entered(body):
	if body.has_method("_BulletDetection"):
		var bullet = BulletPrefab.instantiate()
		get_parent().get_parent().call_deferred("add_child", bullet)
		bullet.position = $BulletSpawner.global_position
		_Do_Reposition(bullet)
		if Character.Target_Enemy != null:
			bullet.MoveDirection = Character.IndicatorDirection
		else:
			bullet.MoveDirection = Vector2(1,0)

	
func _Do_Reposition(bullet_prefab):
	if Character.Reposition_enabled == true and isLv3 == true:
		bullet_prefab.Reposition = true
		bullet_prefab.Reposition_Target = Character.Target_Enemy
		
	

