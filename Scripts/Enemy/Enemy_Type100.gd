extends CharacterBody2D

@onready var BulletSpawner_pos = $BulletSpawner
@onready var BulletSpawner_pos2 = $BulletSpawner2
@onready var BulletSpawner_pos3 = $BulletSpawner3
@onready var HPBar = $HP
@onready var ShootTimer = $Timer
@onready var BossAnimation = $Sprite2D

@export var player_root = "玩家路径" # 玩家路径
@export var move_speed = 100  
@export var wander_direction : Node2D
@export var group_name : String
var y_direction = 1
@export var approachingSpeed = 100
@export var ShootDuration = 3
var Boss_Timer


var bullet1_tscn = preload("res://TSCN/Bullet/bullet_1.tscn")
var bullet2_tscn = preload("res://TSCN/Bullet/bullet_2.tscn")

var Health = 1
@export var MaxHealth = 1000

enum ShootMode{SM1,SM2,Mad}
@export var SM = ShootMode.SM1
var Reposition = false

#射击模式1
@export var SD_SM1 = 0.1
@export var ShootChance_SM1 = 3
var ST_SM1
var SC_SM1 = 3

#射击模式2
@export var SD_SM2 = 0.1
@export var ShootChance_SM2 = 5
var ST_SM2
var SC_SM2 = 5

#射击模式3
@export var SD_SM3 = 0.1
@export var ShootChance_SM3 = 5
var ST_SM3
var SC_SM3 = 5

#移动模式1

#移动模式2

var isdead = false

signal Route_Change_Signal

func _ready():
	SC_SM1 = ShootChance_SM1
	SC_SM2 = ShootChance_SM2
	SC_SM3 = ShootChance_SM3
	Boss_Timer = 0
	Health = MaxHealth
	HPBar.init_value(Health)
	isdead = false
	pass

func _physics_process(delta):
	HPBar.value_1 = Health * 100 / MaxHealth
	if Health >= MaxHealth*3/4:
		#BossAnimation.play("fly")
		_Play_Animation("fly")
		SM = ShootMode.SM1
	elif Health >= MaxHealth /3:
		#BossAnimation.play("attack")
		_Play_Animation("attack")
		SM = ShootMode.SM2
	elif Health <MaxHealth /3:
		#BossAnimation.play("attack")
		_Play_Animation("attack")
		SM = ShootMode.Mad
	#print(Health)
	match SM:
		ShootMode.SM1:
			velocity = wander_direction.direction * move_speed
			Boss_Timer+=delta
			if Boss_Timer >= ShootDuration:
				_ShootBullet_SM1()
				Boss_Timer = 0
			pass
		ShootMode.SM2:
			_FoundTarget(player_root)
			velocity = Vector2(0 , approachingSpeed*y_direction)
			Boss_Timer+=delta
			if Boss_Timer >= ShootDuration:
				_ShootBullet_SM2()
				Boss_Timer = 0
			pass
		ShootMode.Mad:
			if Reposition == false:
				_change_route("Route2")
				wander_direction._get_positions()
				wander_direction._get_next_position()
				Reposition = true
			velocity = wander_direction.direction * move_speed
			Boss_Timer+=delta
			if Boss_Timer >= ShootDuration:
				_ShootBullet_Mad()
				Boss_Timer = 0
			pass
					
	move_and_slide()	
				
	if Health <= 0 and isdead == false:
		isdead = true
		BossAnimation.play("die")
		await BossAnimation.animation_finished
		get_tree().change_scene_to_file("res://TSCN/Scene/StartScene.tscn")
		queue_free()  # 销毁
		
	
func _EnemyDetection():
	pass
	
func _BossDetection():
	pass



func _on_bullet_spawner_body_entered(body):
	pass
	
	
func _FoundTarget(TargetPath):
	var target = get_tree().get_first_node_in_group("Player")
	if target != null:
		var target_position = target.global_position
		if target_position.y > global_position.y + 30:
			y_direction = 1
		elif  target_position.y < global_position.y - 30:
			y_direction = -1
		else:
			y_direction = 0  # 随机选择 -1、0、1
	else:
		pass

func _ShootBullet_SM1():
	ShootTimer.wait_time = SD_SM1
	ShootTimer.start()

func _ShootBullet_SM2():
	ShootTimer.wait_time = SD_SM2
	ShootTimer.start()

func _ShootBullet_Mad():
	ShootTimer.wait_time = SD_SM3
	ShootTimer.start()

func _on_timer_timeout():
	match SM:
		ShootMode.SM1:
			if SC_SM1 > 0:
				SC_SM1 -= 1	
				var bullet = bullet1_tscn.instantiate()
				get_parent().add_child(bullet)
				bullet.position = BulletSpawner_pos.global_position
			else:
				ShootTimer.stop()
				SC_SM1 = ShootChance_SM1
			pass
		ShootMode.SM2:
			if SC_SM2 > 0:
				SC_SM2 -= 1	
				var bullet1 = bullet2_tscn.instantiate()
				var bullet2 = bullet2_tscn.instantiate()
				get_parent().add_child(bullet1)
				get_parent().add_child(bullet2)
				bullet1.position = BulletSpawner_pos2.global_position
				bullet2.position = BulletSpawner_pos3.global_position
			else:
				ShootTimer.stop()
				SC_SM2 = ShootChance_SM2
			pass
		ShootMode.Mad:
			if SC_SM3 > 0:
				SC_SM3 -= 1	
				var player = get_tree().get_first_node_in_group("Player")
				var bullet1 = bullet2_tscn.instantiate()
				var bullet2 = bullet2_tscn.instantiate()
				var bullet3 = bullet1_tscn.instantiate()
				get_parent().add_child(bullet1)
				get_parent().add_child(bullet2)
				get_parent().add_child(bullet3)
				bullet1.position = BulletSpawner_pos2.global_position
				bullet2.position = BulletSpawner_pos3.global_position
				bullet3.position = BulletSpawner_pos.global_position
				if player != null:
					bullet1.MoveDirection = (player.global_position - bullet1.global_position).normalized()
					bullet2.MoveDirection = (player.global_position - bullet2.global_position).normalized()
			else:
				ShootTimer.stop()
				SC_SM3 = ShootChance_SM3
			pass
		
	pass # Replace with function body.
	
func _change_route(routeName):
	group_name = routeName
	Character.emit_signal("Route_Change")
	#print_debug("11")
	
func _Play_Animation(Anim_Name):
	if isdead == false:
		BossAnimation.play(Anim_Name)
	pass
