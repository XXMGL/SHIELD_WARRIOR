extends CharacterBody2D

# 子弹
@onready var Bullet = preload("res://TSCN/Bullet/bullet_2.tscn")
@onready var chaseBullet = preload("res://TSCN/Bullet/bullet_1.tscn")
@onready var ShootTimer = $ShootTimer

# 子弹发射器
@onready var bulletSpawner1 = $BulletSpawner1
@onready var bulletSpawner2 = $BulletSpawner2
@onready var bulletSpawner3 = $BulletSpawner3
@onready var bulletSpawner4 = $BulletSpawner4

var bulletSpawner4RotateDir = 1

# Boss 状态
enum ShootMode{SM1, SM2, Mad, Die}
@export var SM = ShootMode.SM1
@export var SM1_ShootDuraton = 1.5
@export var SM2_ShootDuraton = 0.2
@export var SMM_ShootDuraton = 0.5


# Boss移动
var move_speed = 100
@export var move_direction = Node2D
var group_name : String

# Boss生命
@export var Health = 50
var isDead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ShootTimer.wait_time = SM1_ShootDuraton
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity = move_direction.direction * move_speed
	
	BossState()
	
	if (Health <= 0):
		SM = ShootMode.Die
		isDead = true
	
	move_and_slide()
	

func BossState():
	match (SM):
		ShootMode.SM1:
			# 改变射击速度
			ShootTimer.wait_time = SM1_ShootDuraton
			
			
			pass
		ShootMode.SM2:
			# 改变射击速度
			ShootTimer.wait_time = SM2_ShootDuraton
			
			# 调整射击孔
			var rotateSpeed = 0.02
		
			#print_debug(bulletSpawner4.rotation_degrees)
			
			if (bulletSpawner4.rotation_degrees >= 180):
				bulletSpawner4RotateDir = -1
			elif(bulletSpawner4.rotation_degrees <= 0):
				bulletSpawner4RotateDir = 1
			
			bulletSpawner4.rotation += rotateSpeed * bulletSpawner4RotateDir
			pass
		ShootMode.Mad:
			# 改变射击速度
			ShootTimer.wait_time = SMM_ShootDuraton
			
			var rotateSpeed = 0.01
		
			#print_debug(bulletSpawner4.rotation_degrees)
			
			if (bulletSpawner4.rotation_degrees >= 180):
				bulletSpawner4RotateDir = -1
			elif(bulletSpawner4.rotation_degrees <= 0):
				bulletSpawner4RotateDir = 1
			
			bulletSpawner4.rotation += rotateSpeed * bulletSpawner4RotateDir
			pass
		ShootMode.Die:
			ShootTimer.stop()
			pass
		

func ShootBullet():
	match (SM):
		ShootMode.SM1:
			#print_debug("1")
			var bullet1 = Bullet.instantiate()
			get_parent().add_child(bullet1)
			bullet1.position = bulletSpawner1.global_position
			
			var bullet2 = Bullet.instantiate()
			get_parent().add_child(bullet2)
			bullet2.position = bulletSpawner2.global_position
			
			var bullet3 = Bullet.instantiate()
			get_parent().add_child(bullet3)
			bullet3.position = bulletSpawner3.global_position
			pass
		ShootMode.SM2:
			var bullet = Bullet.instantiate()
			get_parent().add_child(bullet)
			var bulletDirection = (get_node("BulletSpawner4/ShootDirection").global_position - bulletSpawner4.global_position).normalized()

			bullet.position = bulletSpawner4.global_position
			bullet.rotation = atan2(bulletDirection.x,bulletDirection.y)
			bullet.MoveDirection = bulletDirection
			
			pass
		ShootMode.Mad:
			var bullet1 = chaseBullet.instantiate()
			get_parent().add_child(bullet1)
			bullet1.position = bulletSpawner1.global_position
			
			var bullet3 = chaseBullet.instantiate()
			get_parent().add_child(bullet3)
			bullet3.position = bulletSpawner3.global_position
			
			var bullet = Bullet.instantiate()
			get_parent().add_child(bullet)
			var bulletDirection = (get_node("BulletSpawner4/ShootDirection").global_position - bulletSpawner4.global_position).normalized()

			bullet.position = bulletSpawner4.global_position
			bullet.rotation = atan2(bulletDirection.x,bulletDirection.y)
			bullet.MoveDirection = bulletDirection
			
			pass
		ShootMode.Die:
			pass



func _on_shoot_timer_timeout():
	#print_debug("1")
	ShootBullet()


func _EnemyDetection():
	pass
	
