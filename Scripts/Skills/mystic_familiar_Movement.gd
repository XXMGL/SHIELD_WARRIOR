extends CharacterBody2D

@onready var MF_Animation = $AnimatedSprite2D
@onready var MF_Timer = $Timer
@onready var Shield_Timer = $Timer2
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
var is_LV_4_1:bool = false
var is_LV_4_2:bool = false
var is_LV_5_1:bool = false
var is_LV_5_2:bool = false

var has_Shield:bool = false

var branch_index:int = 0

var Shooting_Offset = Character.Shooting_Offset

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
	if is_LV_5_1 == false and is_LV_5_2 == false:
		var newBulletPrefab = BulletPrefab
		var bullet = newBulletPrefab.instantiate()
		get_parent().get_parent().add_child(bullet)
		Shooting_Offset = Character.Shooting_Offset
		var offset_angle = deg_to_rad(randf_range(-Shooting_Offset, Shooting_Offset))
		if is_Lv_3 == true:
			bullet.Damage_Scale = 2
		bullet.position = $BulletSpawner.global_position
		var original_direction = Character.IndicatorDirection
		var rotated_direction = original_direction.rotated(offset_angle)
		if is_LV_4_2 == true:
			bullet.MoveDirection = rotated_direction
		else:
			bullet.MoveDirection = Vector2(1,0)
	elif is_LV_5_1 == true:
		SkillManager.emit_signal("B_Skill2_1")
	elif is_LV_5_2 == true:
		Character._Make_a_Shoot($BulletSpawner.global_position)
		pass

func _MF_Detection():
	if has_Shield == true:
		return true
	else:
		return false

func _on_timer_timeout():
	ShootBullet_MF()
	pass # Replace with function body.
	
func _B_Skill2_up():
	#print_debug(branch_index)
	Skill_Lv += 1
	#print_debug(Skill_Lv)
	if Skill_Lv == 1:
		pass
	elif Skill_Lv == 2:
		MF_Timer.wait_time = 0.5
		pass
	elif Skill_Lv == 3:
		is_Lv_3 == true
	elif Skill_Lv == 4:
		branch_index = SkillManager._Get_branch_index(SkillManager.B_Skill2)
		if branch_index == 1:
			is_LV_4_1 = true
			Shield_Timer.start()
			Character.connect("Gethit",Callable(self,"_Get_Hit"))
			
		elif branch_index == 2:
			is_LV_4_2 = true
		else:
			print_debug("Error")
	elif Skill_Lv == 5:
		if branch_index == 1:
			MF_Timer.wait_time = 3
			is_LV_4_1 = false
			is_LV_5_1 = true
			_initiate_Guardian_Shield()		
		elif branch_index == 2:
			is_LV_4_2 = false
			is_LV_5_2 = true
		else:
			print_debug("Error")
			
			
func _initiate_Guardian_Shield():
	var Slot_in_Scene = get_tree().get_nodes_in_group("Shield_Slot")
	if Slot_in_Scene.size()<1:
		var Slot_tscn = load("res://TSCN/UI/Guardian_Shield_Slot.tscn")
		var new_Slot = Slot_tscn.instantiate()
		SkillManager.add_child(new_Slot)
		new_Slot.Skill_Level = 1

func _Get_Hit():
	Shield_Timer.start()

func _on_timer_2_timeout():
	has_Shield = true
	pass # Replace with function body.
