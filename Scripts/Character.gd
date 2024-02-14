extends CharacterBody2D

@onready var StaminaBar = $CanvasLayer/StaminaBar
@onready var HealthBar = $CanvasLayer/HealthBar
@onready var ShieldSprite = $SHIELD/Sprite2D

# 玩家移动
@export var MOVE_SPEED = 200 #玩家的移动速度
@export var SlowDown = 1 #玩家减速系数
var motion = Vector2() # 玩家移动方向向量

#玩家状态
enum state {STATE_MOVE, STATE_HURT, STATE_DIE, STATE_PARRYING,  STATE_PARRYSTART, STATE_PARRYEND} # 玩家状态
var Player_State = state.STATE_MOVE
@export var ParryDuration = 0.1 #举盾前摇与后摇时间
var parry_timer = 0.0 # 用于控制玩家状态切换
@export var parry_cooldown = 1.0 # 举盾行为内置cd
var parry_CountDown = 0.0 # 用于控制举盾cd
var bullet_1_tscn = preload("res://TSCN/bullet_R_1.tscn") # 预加载子弹类型1
var bullet_1s_tscn = preload("res://TSCN/bullet_R_1s.tscn") # 预加载子弹类型1s
var CanPreciseParry = false # 玩家一次举盾进行精确弹反，只能反弹一次特殊子弹
var canPary = true

#玩家生命值与体力条
@export var Max_stamina = 100 # 玩家最大体力值
@export var Max_health = 100
var stamina = 100
var health  = 100
@export var stamina_Cousume = 20
@export var stamina_Recover = 10
var Recieved_damge = 0

#玩家鼠标操控
var mouse_global_pos
var Indicator
@export var distance = 10
var IndicatorDirection

func _ready():
	stamina = Max_stamina
	health = Max_health
	canPary = true
	StaminaBar.init_value(stamina)
	HealthBar.init_value(health)
	Indicator = $Indicator
	pass


func _process(delta):
	#获取玩家鼠标位置
	mouse_global_pos = get_global_mouse_position()
	IndicatorDirection = (mouse_global_pos - global_position).normalized()
	if IndicatorDirection.x <= 0.6:
		IndicatorDirection.x = 0.6
	Indicator.global_position = global_position + IndicatorDirection*distance
	Indicator.rotation = atan2(IndicatorDirection.y,IndicatorDirection.x)
	
	StaminaBar.value_1 = stamina
	HealthBar.value_1 = health
	_MOVE(MOVE_SPEED / SlowDown) # 减速移动
	match Player_State:
		state.STATE_MOVE:
			ShieldSprite.visible = false
			_OutofStamina()
			SlowDown = 1
			parry_CountDown -= delta
			#体力恢复，大于最大体力值时不再恢复
			stamina += stamina_Recover*delta
			if stamina >= Max_stamina:
				stamina = Max_stamina
			 #只有当玩家按下parry按键并且parry冷却倒计时小于零才能进行格挡
			if Input.is_action_pressed("parry") and parry_CountDown<=0 and canPary == true:
				Player_State = state.STATE_PARRYSTART # 进入Parry前摇状态
				parry_timer = 0.0
			#_MOVE(MOVE_SPEED) # 移动
			pass
		state.STATE_PARRYSTART:
			ShieldSprite.visible = true
			_OutofStamina()
			SlowDown = 2
			CanPreciseParry = true # 每一次举盾期间可以反弹一次特殊子弹
			stamina -= stamina_Cousume *delta
			parry_timer += delta 
			if parry_timer >= ParryDuration / 1.5: # 前摇
				Player_State = state.STATE_PARRYING
			#_MOVE(MOVE_SPEED / SlowDown) # 减速移动
			pass
		state.STATE_PARRYING:
			_OutofStamina()
			SlowDown = 2
			stamina -= stamina_Cousume *delta
			# 松开Parry按键进入后摇
			if not Input.is_action_pressed("parry"):
				Player_State = state.STATE_PARRYEND
				parry_timer = 0.0
			#_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_PARRYEND:
			SlowDown = 2
			parry_timer += delta
			if parry_timer >= ParryDuration:
				Player_State = state.STATE_MOVE
				parry_CountDown = parry_cooldown
			#_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_HURT:
			health -= Recieved_damge
			Recieved_damge = 0
			Player_State = state.STATE_MOVE
			pass
		state.STATE_DIE:
			pass
			

func _MOVE(speed):
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
			
			#将motion变量赋予velocity并且控制玩家移动
			set_velocity(motion)
			move_and_slide()		
			
func _CharacterDetection():
	# 目前只用作碰撞检测时识别node
	pass
	
func _ShootBullet(Bullet):
	var bullet = Bullet.instantiate()
	#get_parent().add_child(bullet) 不能用，因为同时检测碰撞并Add child会报错
	get_parent().call_deferred("add_child", bullet)
	bullet.position = $SHIELD.global_position
	bullet.rotation = Indicator.rotation
	bullet.MoveDirection = IndicatorDirection
	
	
func _OutofStamina():
	if stamina <= 0:
		canPary = false
		parry_timer = 0.0
		Player_State = state.STATE_PARRYEND
	if stamina == Max_stamina and canPary == false:
		canPary = true	





func _on_shield_body_entered(body):
	if body.has_method("_BulletDetection"):
		if Player_State == state.STATE_PARRYING:
			_ShootBullet(bullet_1_tscn)
		# 前摇阶段进行精确弹反提前退出STATE_PARRYSTART进入Parrying状态
		elif Player_State == state.STATE_PARRYSTART:
			_ShootBullet(bullet_1s_tscn)
			Player_State = state.STATE_PARRYING
		# 后摇状态只能发射一次特殊子弹，但是不会提前退出STATE_PARRYEND状态
		elif Player_State == state.STATE_PARRYEND:
			if CanPreciseParry == true:
				_ShootBullet(bullet_1s_tscn)
				CanPreciseParry = false
		elif Player_State == state.STATE_MOVE:
			Player_State = state.STATE_HURT
			Recieved_damge = body._BulletDetection()
			pass

