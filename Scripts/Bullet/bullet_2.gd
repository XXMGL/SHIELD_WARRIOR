extends CharacterBody2D

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity



enum Types{Bullet1, Bullet2}
@export var BulletType = Types.Bullet2

@export var move_speed = 300  # 在x方向的移动速度
var Default_move_speed = 300
enum Origin{From_Enemy, From_Player}
@export var OriginFrom = Origin.From_Enemy
@export var Damage = 10
var Damage_Scale = 1

@export var canRunThrough = false
@export var Reposition = false
var Reposition_Timer = 0
var Reposition_Target:Node2D
var MoveDirection = Vector2(-1 , 0)

@onready var BulletAnimation = $AnimatedSprite2D
#Skill 2.1
var G_Skill2_Active_Lv1_Ac = 1
var G_Skill3_Active_Lv3_Ac = 1


var Bounce_Times = 0 # Bullet bounces times in maximum
var Bouncing_Times = 0

var Bullet_exist_time = 6
var Bullet_exist_timer = 0

var Enemy_index = 0

func _ready():
	LevelManager.connect("Final_Enemy_Die",Callable(self,"_Self_Destroy"))
	BulletAnimation.play("shoot")
	_AC_Calculation()
	if Character.G_Skill2_Active_Lv2 == true and OriginFrom == Origin.From_Player == true:
		Damage_Scale = 1 * (move_speed/Default_move_speed)
	
func _process(delta):   
	if OriginFrom == Origin.From_Player == true and Character.G_Skill3_Active_Lv5 == true:
		_Slow_Down(delta)
	Bullet_exist_timer += delta
	if Bullet_exist_timer >= Bullet_exist_time and Character.G_Skill3_Active_Lv4 == false:
		_Self_Destroy()         
	if OriginFrom == Origin.From_Player:
		#print_debug(global_position)
		pass
	
	match OriginFrom:
		Origin.From_Enemy:
			pass
		Origin.From_Player:
			pass
	if Reposition == true:
		Reposition_Timer += delta
		if Reposition_Timer >= 0.25:
			#print_debug(Reposition_Target)
			if Reposition_Target != null and Reposition_Target.isDead == false:
				MoveDirection = (Reposition_Target.global_position - global_position).normalized()
				move_speed *= Character.R_Bullet_ac
				Reposition = false
	match BulletType:
		Types.Bullet1:
			_ToPlayer()
		Types.Bullet2:
			pass
	velocity = move_speed*MoveDirection
	#rotation = atan2(MoveDirection.x,MoveDirection.y)
	#look_at(MoveDirection)
	var next_position = global_position + velocity * delta
	look_at(next_position)
	move_and_slide()	


func _on_detector_body_entered(body):
	if body.has_method("get_name") and (body.get_name() == "R_Wall" or body.get_name() == "L_Wall" or body.get_name() == "T_Wall" or body.get_name() == "D_Wall" ):
		if Bounce_Times > 0:
			if Character.G_Skill3_Active_Lv5 == true:
				Damage_Scale += 0.2
			if body.get_name() == "R_Wall" or body.get_name() == "L_Wall":
				MoveDirection.x =  - MoveDirection.x
			elif body.get_name() == "T_Wall" or body.get_name() == "D_Wall":
				MoveDirection.y =  - MoveDirection.y
			Bounce_Times -= 1
			#print_debug(Bullet_exist_timer)
		else:
			queue_free()
	if OriginFrom == Origin.From_Enemy and body.has_method("_CharacterDetection"):
		#print("11")
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_WingManDetection"):
		queue_free() # 销毁
	if OriginFrom == Origin.From_Enemy and body.has_method("_Bubble_Detection"):
		if body._Bubble_Detection() == true:
			#body.queue_free()
			#queue_free() # 销毁
			pass
	if OriginFrom == Origin.From_Enemy and body.has_method("_MF_Detection"):
		if body.has_Shield != null and body.has_Shield == true:
			body.has_Shield = false
			queue_free() # 销毁
	if OriginFrom == Origin.From_Player and body.has_method("_EnemyDetection"):
		#print_debug("11")
		if Character.G_Skill3_Active_Lv2 == true:
			if Bullet_exist_timer >= 10:
				Bullet_exist_timer = 10
			Damage_Scale += Bullet_exist_timer
			pass
		#print_debug("Damage: ",Damage * Damage_Scale, " Damage Scale: ", Damage_Scale)
		body.Health -= Damage * Damage_Scale
		if canRunThrough:
			if body.has_method("_BossDetection"):
				queue_free()
			pass
		else:
			queue_free()  # 销毁子弹
		
				
func _BulletDetection():
	pass

func _GetDamage():
	return Damage * Damage_Scale
	
func _ToPlayer():
	var target = get_tree().get_first_node_in_group("Player")
	MoveDirection = (target.global_position - global_position).normalized()
	
func _Self_Destroy():
	queue_free()

func _AC_Calculation():
	Default_move_speed = move_speed
	if Character.G_Skill2_Active_Lv1 == true:
		G_Skill2_Active_Lv1_Ac = 1.2
		#print_debug("Move Speed: ",move_speed)
	if Character.G_Skill3_Active_Lv3 == true:
		G_Skill3_Active_Lv3_Ac = 0.7
	if OriginFrom == Origin.From_Player:
		move_speed = 400
		Default_move_speed = move_speed
		move_speed *= G_Skill2_Active_Lv1_Ac * G_Skill3_Active_Lv3_Ac

func _Slow_Down(delta):
	if move_speed >= 0:
		move_speed -= delta * 35
	if move_speed <= 0:
		move_speed = 0
		#print_debug(move_speed)
		
func OriginFromEnemy():
	if OriginFrom == Origin.From_Player:
		return false
	elif OriginFrom == Origin.From_Enemy:
		return true
	
