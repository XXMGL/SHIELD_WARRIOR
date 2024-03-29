extends CharacterBody2D

#敌人基础数据
@export var move_speed = 100
var move_speed_default = 100  
@export var Health = 1
var pre_Health
@export var ShootDuration = 2.0
@export var wander_direction : Node2D
@export var group_name : String
@export var approach_speed = 50  # 在y轴上向玩家靠近的速度
#@export var player_root = "Character" # 玩家路径
var y_direction:int
var x_direction:int

@onready var EnemyAnimator = $AnimatedSprite2D


var bullet1_tscn = preload("res://TSCN/Bullet/bullet_1.tscn")
var bullet2_tscn = preload("res://TSCN/Bullet/bullet_2.tscn")
var exp_tscn = preload("res://TSCN/Player/LevelUp/exp.tscn")
var Shoot_timer = 0.0

#敌人类型
enum Types {Enemy1, Enemy2, Enemy3, Enemy4, Enemy5, Enemy6, Enemy7}
@export var Enemy_type = Types.Enemy1
@export var direct_attacker = false
@export var suicide_attacker = false
@export var direct_attack_damage = 0

# 近战攻击敌人状态
enum DirectAttackerState {wander, transfer, attacking, attack_finish}
var direct_attacker_state = DirectAttackerState.wander
var direct_attacker_is_attack = false
var target_position

#Timer
var Move_Timer = 0.0
var Shoot_Timer = 0.0

#exp
@export var exp_Amout = 5
@export var exp_Num = 1

#G_Skill4
var G_Skill4_Slow = false
var isDead = false

#G_Skill5
var Poison_Debuff = 0
var Poison_Timer = 0
var Poison_Trigger_Duration = 2
var Poison_Trigger_Duration_Default = 2

#B_Skill3
var Freeze = false
var Freeze_Timer = 0

@export var Enemy_index = 1

signal Get_Hit
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("Get_Hit",Callable(self,"G_Skill5"))
	move_speed_default = move_speed
	pre_Health = Health
	Poison_Trigger_Duration_Default = Poison_Trigger_Duration
	match Enemy_type:
		Types.Enemy1:
			pass
		Types.Enemy2:			
			pass
		Types.Enemy3:
			pass
		Types.Enemy4:
			pass
		Types.Enemy5:
			pass
		Types.Enemy6:
			var AttackTimer = $AttackTimer
			AttackTimer.wait_time = ShootDuration
			AttackTimer.start()
			pass
		Types.Enemy7:
			var AttackTimer = $AttackTimer
			AttackTimer.wait_time = ShootDuration
			AttackTimer.start()
			pass
	
	if CharacterData.G_Skill4_Active_Lv1 == true:
		move_speed = 0.9*move_speed_default
		move_speed_default = move_speed
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match Enemy_type:
		Types.Enemy1:
			_Play_Animation("Fly")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet(bullet1_tscn)
				Shoot_timer = 0
			pass
		Types.Enemy2:
			_Play_Animation("Fly")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet(bullet2_tscn)
				Shoot_timer = 0
			pass
		Types.Enemy3:
			_Play_Animation("Fly")
			pass
		Types.Enemy4:
			_Play_Animation("Fly")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet_Enemy4()
				Shoot_timer = 0
			pass
		Types.Enemy5:
			_Play_Animation("Fly")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet_Enemy5()
				Shoot_timer = 0
			pass	
		Types.Enemy6:
			if (!isDead):
				if (direct_attacker_state == DirectAttackerState.wander):
					EnemyAnimator.play("Fly")
				elif (direct_attacker_state == DirectAttackerState.transfer):
					if (!direct_attacker_is_attack):
						direct_attacker_is_attack = true
						EnemyAnimator.play("Attack")
						await EnemyAnimator.animation_finished
						direct_attacker_state = DirectAttackerState.attacking
				elif (direct_attacker_state == DirectAttackerState.attack_finish):
					if (direct_attacker_is_attack):
						direct_attacker_is_attack = false
					EnemyAnimator.play("Fly")
			pass
		Types.Enemy7:
			if (!isDead):
				if (direct_attacker_state == DirectAttackerState.wander):
					EnemyAnimator.play("Fly")
					Shoot_timer += delta
					if Shoot_timer >= ShootDuration/10:
						_ShootBullet(bullet1_tscn)
						Shoot_timer = 0
				elif (direct_attacker_state == DirectAttackerState.transfer):
					if (!direct_attacker_is_attack):
						direct_attacker_is_attack = true
						EnemyAnimator.play("Attack")
						await EnemyAnimator.animation_finished
						direct_attacker_state = DirectAttackerState.attacking
				elif (direct_attacker_state == DirectAttackerState.attack_finish):
					if (direct_attacker_is_attack):
						direct_attacker_is_attack = false
					EnemyAnimator.play("Fly")
			pass
	if Poison_Debuff > 0:
		_Poison_Dot(delta)
			
	if Health <= 0 and isDead == false:
		isDead = true
		#remove_from_group("Enemies")
		EnemyAnimator.play("Die")
		await EnemyAnimator.animation_finished
		_Die()  # 销毁
	
func _physics_process(delta):
	_Get_Hit()
	_Freeze(delta)
	match Enemy_type:
		Types.Enemy1:
			_FoundTarget()		
			# 在x方向上获得随即方向,每0.5秒随机获得方向
			#print_debug(" Move_Timer: ", Move_Timer)
			Move_Timer += delta
			if Move_Timer >= 0.5:
				x_direction = randi_range(-1, 1)  # 随机选择 -1、0、1
				#print_debug("x_direction: ", x_direction, " Move_Timer: ", Move_Timer)
				Move_Timer = 0
			var x_velocity = x_direction * move_speed
			var y_velocity = y_direction * approach_speed
			velocity = Vector2(x_velocity,y_velocity)	
			#print_debug("x_direction: ", x_direction)
			pass
		Types.Enemy2:
			velocity = wander_direction.direction * move_speed
			pass
		Types.Enemy3:
			velocity = wander_direction.direction * move_speed
			pass
		Types.Enemy4:
			var bullet_spawners
			bullet_spawners = $BulletSpawners
			bullet_spawners.rotate(0.15)
			velocity = wander_direction.direction * move_speed
			pass
		Types.Enemy5:
			velocity = wander_direction.direction * move_speed
			pass
		Types.Enemy6:
			match direct_attacker_state:
				DirectAttackerState.wander:
					velocity = (wander_direction.current_position.position - position).normalized() * move_speed
					pass
				DirectAttackerState.transfer:
					velocity = Vector2.ZERO
					pass
				DirectAttackerState.attacking:
					velocity = (target_position - position).normalized() * 5 * move_speed
					if (global_position.distance_to(target_position) < 10):
						direct_attacker_state = DirectAttackerState.attack_finish
					pass
				DirectAttackerState.attack_finish:
					velocity = (wander_direction.current_position.position - position).normalized() * 5 * move_speed
					if (global_position.distance_to(wander_direction.current_position.position) < 20):
						direct_attacker_state = DirectAttackerState.wander
					pass
		Types.Enemy7:
			match direct_attacker_state:
				DirectAttackerState.wander:
					velocity = (wander_direction.current_position.position - position).normalized() * move_speed
					pass
				DirectAttackerState.transfer:
					velocity = Vector2.ZERO
					pass
				DirectAttackerState.attacking:
					# EnemyAnimator.play("Attack")
					velocity = (target_position - position).normalized() * 5 * move_speed
					if (global_position.distance_to(target_position) < 10):
						direct_attacker_state = DirectAttackerState.attack_finish
					pass
				DirectAttackerState.attack_finish:
					# EnemyAnimator.play("Fly")
					velocity = (wander_direction.current_position.position - position).normalized() * 5 * move_speed
					if (global_position.distance_to(wander_direction.current_position.position) < 20):
						direct_attacker_state = DirectAttackerState.wander
					pass
	if Health <= 0:
		velocity = Vector2(0,0)
	move_and_slide()	
	pass


func _FoundTarget():
	var target = get_tree().get_first_node_in_group("Player")
	if target != null:
		var target_position = target.global_position
		if target_position.y > global_position.y:
			y_direction = 1
		elif  target_position.y < global_position.y:
			y_direction = -1
		else:
			y_direction = randf_range(-1, 1)  # 随机选择 -1、0、1
	else:
		pass
		
func _ShootBullet(bullet_Prefab):
	var bullet = bullet_Prefab.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawner.global_position
	bullet.Enemy_index = Enemy_index
	
func _ShootBullet_Enemy4():
	var bullet1 = bullet2_tscn.instantiate()
	get_parent().add_child(bullet1)
	var bullet1Direction = (get_node("BulletSpawners/bullet_spawner_1").global_position - global_position).normalized()
	bullet1.position = get_node("BulletSpawners/bullet_spawner_1").global_position
	bullet1.rotation = atan2(bullet1Direction.x, bullet1Direction.y)
	#print_debug("bullet1Direction: ", bullet1Direction)
	bullet1.MoveDirection = bullet1Direction
	bullet1.Enemy_index = Enemy_index
	
	var bullet2= bullet2_tscn.instantiate()
	get_parent().add_child(bullet2)
	var bullet2Direction = (get_node("BulletSpawners/bullet_spawner_2").global_position - global_position ).normalized()
	bullet2.position = get_node("BulletSpawners/bullet_spawner_2").global_position
	bullet2.rotation = atan2(bullet2Direction.x, bullet2Direction.y)
	bullet2.MoveDirection = bullet2Direction
	bullet2.Enemy_index = Enemy_index
	
func _ShootBullet_Enemy5():
	var bullet1 = bullet2_tscn.instantiate()
	var bullet2 = bullet2_tscn.instantiate()
	var bullet3 = bullet2_tscn.instantiate()
	
	get_parent().add_child(bullet1)
	get_parent().add_child(bullet2)
	get_parent().add_child(bullet3)
	
	var bullet1Direction = (get_node("BulletSpawner").global_position - global_position).normalized()
	var bullet2Direction = (get_node("BulletSpawner2").global_position - global_position).normalized()
	var bullet3Direction = (get_node("BulletSpawner3").global_position - global_position).normalized()
	
	bullet1.position = get_node("BulletSpawner").global_position
	bullet1.rotation = atan2(bullet1Direction.x,bullet1Direction.y)
	bullet1.MoveDirection = bullet1Direction
	
	bullet2.position = get_node("BulletSpawner2").global_position
	bullet2.rotation = atan2(bullet2Direction.x,bullet2Direction.y)
	bullet2.MoveDirection = bullet2Direction
	
	bullet3.position = get_node("BulletSpawner3").global_position
	bullet3.rotation = atan2(bullet3Direction.x,bullet3Direction.y)
	bullet3.MoveDirection = bullet3Direction
	
	bullet1.Enemy_index = Enemy_index
	bullet2.Enemy_index = Enemy_index
	bullet3.Enemy_index = Enemy_index
	
	
func _EnemyDetection():
	pass


func _on_bullet_spawner_body_entered(_body):
	pass
	
func _change_route(routeName):
	group_name = routeName
	Character.emit_signal("Route_Change")
	#print_debug("Change Route to: ", group_name)

func _on_detector_body_entered(body):
	if body.has_method("_CharacterDetection"):
		if (suicide_attacker):
			queue_free()  # 销毁子弹
		pass
		
func _GetDamage():
	return direct_attack_damage

func _isDirectAttacker():
	return direct_attacker
	
func _Die():
	for i in range(exp_Amout):
		var exp = exp_tscn.instantiate()
		get_parent().add_child(exp)
		exp.position = global_position
		exp.exp_Num = exp_Num
		CharacterData.emit_signal("EnemyDie")
	queue_free()
		
		
func _Play_Animation(Anim_Name):
	if isDead == false:
		EnemyAnimator.play(Anim_Name)
	pass

func _on_attack_timer_timeout():
	#print_debug("1")
	# is_direct_attack = true
	direct_attacker_state = DirectAttackerState.transfer
	
	var target = get_tree().get_first_node_in_group("Player")
	if target != null:
		target_position = target.global_position

func _Get_Hit():
	if Health < pre_Health:
		emit_signal("Get_Hit")
		pre_Health = Health
	if Health > pre_Health:
		pre_Health = Health
	pass
	
func G_Skill5():
	if CharacterData.G_Skill5_Active_Lv2 == true:
		Poison_Debuff += 1
	pass

func _Poison_Dot(delta):
	Poison_Timer += delta
	if Poison_Timer >= Poison_Trigger_Duration:
		Health -= 1*Poison_Debuff
		#print_debug("毒发： ",Poison_Debuff)
		Poison_Timer = 0
	pass
	
func _Freeze(delta):
	if Freeze == true:
		Freeze_Timer += delta
		move_speed = 0
		if Freeze_Timer >= 3:
			Freeze_Timer = 0
			move_speed = move_speed_default
			Freeze = false
