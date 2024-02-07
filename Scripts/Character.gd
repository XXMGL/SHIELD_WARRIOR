extends CharacterBody2D

@export var MOVE_SPEED = 200 #玩家的移动速度
@export var SlowDown = 2
@export var ParryDuration = 0.1
var motion = Vector2()
enum state {STATE_MOVE, STATE_HURT, STATE_DIE, STATE_PARRYING,  STATE_PARRYSTART, STATE_PARRYEND}
var Player_State = state.STATE_MOVE
var parry_timer = 0.0


func _ready():
	pass


func _process(delta):
	match Player_State:
		state.STATE_MOVE:
			if Input.is_action_pressed("parry"):
				Player_State = state.STATE_PARRYING
				parry_timer = 0.0
			_MOVE(MOVE_SPEED)
			pass
		state.STATE_PARRYSTART:
			print("Parry Start")
			parry_timer += delta
			if parry_timer >= ParryDuration:
				Player_State = state.STATE_PARRYING
			_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_PARRYING:
			print("Parrying")
			if not Input.is_action_pressed("parry"):
				Player_State = state.STATE_PARRYEND
				parry_timer = 0.0
			_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_PARRYEND:
			print("Parry End")
			parry_timer += delta
			if parry_timer >= ParryDuration:
				Player_State = state.STATE_MOVE
			_MOVE(MOVE_SPEED / SlowDown)
			pass
		state.STATE_HURT:
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
	pass	
	
	
	
