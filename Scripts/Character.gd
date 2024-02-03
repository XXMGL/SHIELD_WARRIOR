extends CharacterBody2D

@export var MOVE_SPEED = 200 #玩家的移动速度
var motion = Vector2()
enum {STATE_PAIRING, STATE_MOVE, STATE_HURT, STATE_DIE}
var state = STATE_MOVE

func _process(delta):
	match state:
		STATE_MOVE:
			if Input.is_action_pressed("pair"):
				state = STATE_PAIRING
			
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
			motion *= MOVE_SPEED
			
			#将motion变量赋予velocity并且控制玩家移动
			set_velocity(motion)
			move_and_slide()
			pass
		STATE_PAIRING:
			print("Pair")
			state = STATE_MOVE
			pass
		STATE_HURT:
			pass
		STATE_DIE:
			pass
			
			
	
	
	
