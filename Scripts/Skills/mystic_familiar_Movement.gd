extends CharacterBody2D

@onready var MF_Animation = $AnimatedSprite2D
@onready var MF_Timer = $Timer
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

var Skill_Lv = 0

var is_Lv_3:bool = false

var is_Guardian:bool = false

func _ready():
	MF_Timer.start()
	SkillManager.connect("B_Skill2_up",Callable(self,"_B_Skill2_up"))
	target = get_tree().get_first_node_in_group("Player")
	pass

func _physics_process(delta):
	MF_Animation.play("Fly")
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
	
func ShootBullet_MF():
	var newBulletPrefab = BulletPrefab
	var bullet = newBulletPrefab.instantiate()
	get_parent().get_parent().add_child(bullet)
	#get_parent().get_parent().call_deferred("add_child", bullet)
	if is_Lv_3 == true:
		bullet.Damage_Scale = 2
	bullet.position = $BulletSpawner.global_position
	if Character.Target_Enemy != null:
		bullet.MoveDirection = Character.IndicatorDirection
	else:
		bullet.MoveDirection = Vector2(1,0)


func _on_timer_timeout():
	ShootBullet_MF()
	pass # Replace with function body.
	
func _B_Skill2_up():
	Skill_Lv += 1
	print_debug(Skill_Lv)
	if Skill_Lv == 1:
		pass
	elif Skill_Lv == 2:
		MF_Timer.wait_time = 0.5
		pass
	elif Skill_Lv == 3:
		is_Lv_3 == true
	pass