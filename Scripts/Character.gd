extends CharacterBody2D

@onready var StaminaBar = $CanvasLayer/Sprite2D/StaminaBar
@onready var HealthBar = $CanvasLayer/Sprite2D/HealthBar
@onready var ShieldSprite = $SHIELD/Sprite2D
@onready var ShieldShadow = $SHIELD/Shadow
@onready var CharacterAnimation = $Sprite2D
@onready var Exp_Bar = $CanvasLayer/EXP/EXP_BAR
@onready var Level_Num_InCanvas = $CanvasLayer/Sprite2D/LEVEL/LevelNum
@onready var OnHit_Timer = $OnHit_Timer

# 玩家移动
@export var Basic_movespeed = 200
var MOVE_SPEED = 200 #玩家的移动速度
@export var SlowDown = 1 #玩家减速系数
var motion = Vector2() # 玩家移动方向向量

#玩家状态
@export var Allow_To_Control = true
enum state {STATE_MOVE, STATE_HURT, STATE_DIE, STATE_PARRYING,  STATE_PARRYSTART, STATE_PARRYEND} # 玩家状态
var Player_State = state.STATE_MOVE
@export var ParryDuration = 0.1 #举盾前摇与后摇时间
var parry_timer = 0.0 # 用于控制玩家状态切换
@export var parry_cooldown = 1.0 # 举盾行为内置cd
var parry_CountDown = 0.0 # 用于控制举盾cd
var bullet_1_tscn = preload("res://TSCN/Bullet/bullet_R_1.tscn") # 预加载子弹类型1
var bullet_1s_tscn = preload("res://TSCN/Bullet/bullet_R_1s.tscn") # 预加载子弹类型1s
var bullet_prefab
var CanPreciseParry = false # 玩家一次举盾进行精确弹反，只能反弹一次特殊子弹
var canPary = true
var isParring = false
var isDead = false
var isShoot = false #用于控制玩家是否已经进行过射击

#玩家生命值与体力条
@export var Basic_health = 100
@export var Basic_stamina = 100
var Max_stamina = 100 # 玩家最大体力值
var Max_health = 100
var stamina = 100
var health  = 100
@export var stamina_Cousume = 20
@export var stamina_Recover = 10
var Recieved_damge = 0
var damage_Scale = 1# 控制受到伤害幅度

#玩家鼠标操控
var mouse_global_pos
var Indicator
@export var distance = 10
var IndicatorDirection
@export var Shooting_Offset = 10
var Shield_position

signal Route_Change
signal Gethit
signal precise_Parry
#signal Recovery

#角色等级系统
var LevelNum = 1
var Exp = 0
var Exp_to_NextLevel = 60

#技能组
#1 Shards_Shoot
var Shards_Shoot_enabled : bool = false
var Shards_Acount = 1

#2 Reposition
var Reposition_enabled : bool = false
var R_Bullet_ac = 1.0
var Target_Enemy

#3 Wing Man

#4 Resilient Heart
var Resilient_Heart_enabled : bool = false
var HeartNum = 3

#1.1 Guardian Shield
var Guardian_Shield_enabled: bool = false

func _ready():
	# 一些数据初始化
	MOVE_SPEED = Basic_movespeed
	Max_health = Basic_health
	Max_stamina = Basic_stamina
	Exp_Bar.max_value = Exp_to_NextLevel
	Level_Num_InCanvas.text = str(LevelNum)
	
	stamina = Max_stamina
	health = Max_health
	canPary = true
	isParring = false
	StaminaBar.init_value(stamina)
	HealthBar.init_value(health)
	Indicator = $Indicator
	bullet_prefab = bullet_1_tscn
	pass


func _process(delta):
	if Reposition_enabled == true:
		#获取最近的敌人单位
		Target_Enemy = get_closest_node_in_group("Enemies")
	#获取玩家鼠标位置
	mouse_global_pos = get_global_mouse_position()
	#设置方向指示器方向
	IndicatorDirection = (mouse_global_pos - global_position).normalized()
	#设置指示器位置
	if IndicatorDirection.x <= 0.6:
		IndicatorDirection.x = 0.6
	Indicator.global_position = global_position + IndicatorDirection*distance
	Indicator.rotation = atan2(IndicatorDirection.y,IndicatorDirection.x)
	#设置UI
	Exp_Bar.value = Exp
	StaminaBar.value_1 = stamina
	HealthBar.value_1 = health
	#玩家移动
	_MOVE(MOVE_SPEED / SlowDown) # 减速移动
	#玩家升级
	_LevelingUp()
	#耐力耗尽
	_OutofStamina()
	
	if motion.length() >= 0.01:
		#CharacterAnimation.play("running")
		_Character_Animation_Play("running")
	else :
		#CharacterAnimation.play("idle")
		_Character_Animation_Play("idle")
	
	if health <= 0 and isDead == false:
		isDead = true
		Player_State = state.STATE_DIE
	
	match Player_State:
		state.STATE_MOVE:
			ShieldSprite.visible = false
			ShieldShadow.visible = false
			#_OutofStamina()
			SlowDown = 1
			parry_CountDown -= delta
			#体力恢复，大于最大体力值时不再恢复
			stamina += stamina_Recover*delta
			if stamina >= Max_stamina:
				stamina = Max_stamina
			 #只有当玩家按下parry按键并且parry冷却倒计时小于零才能进行格挡
			if Input.is_action_pressed("parry") and parry_CountDown<=0 and canPary == true:
				Player_State = state.STATE_PARRYSTART # 进入Parry前摇状态
				#ShieldSprite.play("ParryStart")
				_Shield_Animation_Play("ParryStart")
				parry_timer = 0.0
			#_MOVE(MOVE_SPEED) # 移动
			pass
		state.STATE_PARRYSTART:
			ShieldSprite.visible = true
			ShieldShadow.visible = true
			#_OutofStamina()
			SlowDown = 2
			CanPreciseParry = true # 每一次举盾期间可以反弹一次特殊子弹
			stamina -= stamina_Cousume *delta
			parry_timer += delta 
			if parry_timer >= ParryDuration / 1.5: # 前摇
				Player_State = state.STATE_PARRYING
			#_MOVE(MOVE_SPEED / SlowDown) # 减速移动
			pass
		state.STATE_PARRYING:
			#ShieldSprite.play("Parrying")
			_Shield_Animation_Play("Parrying")
			#_OutofStamina()
			SlowDown = 2
			stamina -= stamina_Cousume *delta
			# 松开Parry按键进入后摇
			if not Input.is_action_pressed("parry"):
				Player_State = state.STATE_PARRYEND
				#ShieldSprite.play("ParryEnd")
				_Shield_Animation_Play("ParryEnd")
				parry_timer = 0.0
			#_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_PARRYEND:
			# _Shield_Animation_Play("ParryEnd")
			
			SlowDown = 2
			parry_timer += delta
			if parry_timer >= ParryDuration:
				Player_State = state.STATE_MOVE
				parry_CountDown = parry_cooldown
			#_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_HURT:
			emit_signal("Gethit")
			#print_debug("damage_Scale: ",damage_Scale)
			health -= Recieved_damge*damage_Scale
			#print_debug("Recieved_damge: ",Recieved_damge*damage_Scale)
			damage_Scale = 1
			Recieved_damge = 0
			Player_State = state.STATE_MOVE
			pass
		state.STATE_DIE:
			CharacterAnimation.play("dead")
			await CharacterAnimation.animation_finished
			_Die()
			pass
			

func _MOVE(speed):
		if Allow_To_Control == true:
			motion = Vector2(0,0) #初始化玩家的移动向量w	
			# 检测键盘输入并更新移动向量
			if Input.is_action_pressed("move_right"):
				motion.x += 1
			if Input.is_action_pressed("move_left"):
				motion.x -= 1
			if Input.is_action_pressed("move_down"):
				motion.y += 1
			if Input.is_action_pressed("move_up"):
				motion.y -= 1
				
			#将移动向量归一化，防止对角线移动速度更快
			motion = motion.normalized()
			
			#将移动向量乘以移动速度乘以delta来实现平滑的移动
			motion *= speed
			
		elif Allow_To_Control == false:
			motion = Vector2(1,0) #初始化玩家的移动向量w	
			#将移动向量归一化，防止对角线移动速度更快
			motion = motion.normalized()			
			#将移动向量乘以移动速度乘以delta来实现平滑的移动
			motion *= speed
			pass
		#将motion变量赋予velocity并且控制玩家移动
		set_velocity(motion)
		move_and_slide()		
			
func _CharacterDetection():
	# 目前只用作碰撞检测时识别node
	pass
	
func _ShootBullet(Bullet,DamageScale,position):
	var bullet = Bullet.instantiate()
	#get_parent().add_child(bullet) 不能用，因为同时检测碰撞并Add child会报错
	get_parent().call_deferred("add_child", bullet)
	var offset_angle = deg_to_rad(randf_range(-Shooting_Offset, Shooting_Offset))
	#print_debug(offset_angle)
	var original_direction = IndicatorDirection
	var rotated_direction = original_direction.rotated(offset_angle)
	_Do_Reposition(bullet)
	#bullet.Reposition_Target = Target_Enemy
	bullet.Damage *= DamageScale
	bullet.position = position
	bullet.rotation = Indicator.rotation
	bullet.MoveDirection = rotated_direction
	
	Trigger_WM()

func _Make_a_Shoot(position):
	isShoot = true
	_Set_Bullet_Prefab()
	_Do_ShardsShoot(bullet_prefab, position)
	if isShoot == true:
		_ShootBullet(bullet_prefab , 1, position)
		isShoot = false
	bullet_prefab = bullet_1_tscn
	
	
func _OutofStamina():
	if stamina <= 0:
		canPary = false
		stamina += 1 #使Stamina不小于0，以便于parry_timer不会被一直设置为0
		parry_timer = 0.0
		Player_State = state.STATE_PARRYEND
		ShieldSprite.play("ParryEnd")
	if stamina == Max_stamina and canPary == false:
		canPary = true	





func _on_shield_body_entered(body):
	if body.has_method("_BulletDetection") or (body.has_method("_isDirectAttacker")and body._isDirectAttacker()):
		if Player_State == state.STATE_PARRYING or Player_State == state.STATE_PARRYSTART or Player_State == state.STATE_PARRYEND:
			_Make_a_Shoot($SHIELD.global_position)
		elif Player_State == state.STATE_MOVE:
			Player_State = state.STATE_HURT
			Recieved_damge = body._GetDamage()
			pass
		if body.has_method("_isDirectAttacker") and body.suicide_attacker:
			body.queue_free()
		


func _Set_Bullet_Prefab():
	match Player_State:
				state.STATE_PARRYING:
					bullet_prefab = bullet_1_tscn
					pass
				state.STATE_PARRYSTART:
					emit_signal("precise_Parry")
					bullet_prefab = bullet_1s_tscn
					Player_State = state.STATE_PARRYING
					pass
				state.STATE_PARRYEND:
					if CanPreciseParry == true:
						emit_signal("precise_Parry")
						bullet_prefab = bullet_1s_tscn
						CanPreciseParry = false
					pass

func get_closest_node_in_group(group_name: String) -> Node2D:
	var mouse_position = get_global_mouse_position()
	var closest_distance = INF  # 初始化一个非常大的值
	var closest_node = null
	var group_nodes = get_tree().get_nodes_in_group(group_name)
	if group_nodes != null:
		for node in group_nodes:
			if node is Node2D: 
				var node_position = node.global_position
				var distance = mouse_position.distance_to(node_position)
				if distance < closest_distance:
					closest_distance = distance
					closest_node = node
	return closest_node

func _LevelingUp():
	if Exp >= Exp_to_NextLevel:
		Exp = 0
		LevelNum += 1
		Exp_to_NextLevel += 45
		Exp_Bar.max_value = Exp_to_NextLevel
		Level_Num_InCanvas.text = str(LevelNum)
	pass
	
func _hide_UI():
	var UI = $CanvasLayer
	UI.visible = false
	
func _Show_UI():
	var UI = $CanvasLayer
	UI.visible = true
	
func _Die():
	get_tree().change_scene_to_file("res://TSCN/Scene/end_scene.tscn")
	pass

func _Character_Animation_Play(Animation_Name):
	if isDead == false:
		CharacterAnimation.play(Animation_Name)
		
func _Shield_Animation_Play(Animation_Name):
	if isDead == false:
		ShieldSprite.play(Animation_Name)
		
	
	
#Skill1 ShardsShoot
func _Do_ShardsShoot(bullet_prefab , position):
	if Shards_Shoot_enabled == true and isShoot == true:
		for i in Shards_Acount:
			_ShootBullet(bullet_prefab , 0.3, position)
		isShoot = false

#Skill2 Repositioning
func _Do_Reposition(bullet_prefab):
	if Reposition_enabled == true:
		bullet_prefab.Reposition = true
		bullet_prefab.Reposition_Target = Target_Enemy
		
#Skill3 WingMan
func Trigger_WM():
	var childs = get_children()
	#var WMs = []
	for child in childs:
		if child.is_in_group("WM") and child.isLv2 == true:
			#print_debug(child)
			child.ShootBullet_WM()
	pass	
	
#Skill4 Resilient Heart
func _R_Heart():
	var R_Heart_Bar = get_tree().get_first_node_in_group("R_Heart")
	if R_Heart_Bar!=null:
		R_Heart_Bar.queue_free()
	var R_Heart_tscn = load("res://TSCN/UI/Heart.tscn")
	var Location = $CanvasLayer/Sprite2D
	var Heart_Bar = R_Heart_tscn.instantiate()
	Location.add_child(Heart_Bar)
	pass
	
func _Get_Shield_position():
	Shield_position = $SHIELD.global_position
	return $SHIELD.global_position

func _Rebirth():
	Player_State = state.STATE_MOVE
	health = CharacterData.Basic_health
	isDead = false
	HeartNum = 3
	LevelNum = 1
	#Level_Num_InCanvas = str(LevelNum)
