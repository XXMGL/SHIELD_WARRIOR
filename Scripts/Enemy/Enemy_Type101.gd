extends CharacterBody2D

# 尾巴
var tail = preload("res://TSCN/Enemy/Enemies/enemy_type_101_Tail.tscn")
@onready var tailGenerateTimer = $Tail_Generate_Timer
var tailGenerateDuration = 0.8
var tails = []
var spawnLocation

# 子弹
@onready var Bullet = preload("res://TSCN/Bullet/bullet_2.tscn")
@onready var ShootTimer = $ShootTimer
@export var ShootDuration = 0.5
var shooterCalmDown = true

# 子弹发射器
@onready var bulletSpawner1 = $BulletSpawner1
@onready var bulletSpawner2 = $BulletSpawner2
@onready var bulletSpawner3 = $BulletSpawner3
@onready var bulletSpawner4 = $BulletSpawner4
@onready var bulletSpawner5 = $BulletSpawner5
@onready var bulletSpawner6 = $BulletSpawner6
@onready var bulletSpawner7 = $BulletSpawner7
@onready var bulletSpawner8 = $BulletSpawner8

var bulletSpawners = []

# 移动
@export var move_direction = Node2D
@export var move_speed = 100
@export var group_name : String

# 生命
@onready var HPBar = $HP
var Health = 1
@export var MaxHealth = 200
var canBeHurt = false
var isDead = false

# Boss 状态
enum ShootMode{SM1, SM2, Mad, Weak, Die}
@export var SM = ShootMode.SM1
var isWeak = false


# Called when the node enters the scene tree for the first time.
func _ready():
	HPBar.visible = false
	HPBar.init_value(Health)
	spawnLocation = global_position
	bulletSpawners = [bulletSpawner1, bulletSpawner2,bulletSpawner3,bulletSpawner4,bulletSpawner5,bulletSpawner6,bulletSpawner7,bulletSpawner8]
	tailGenerateTimer.wait_time = tailGenerateDuration
	ShootTimer.wait_time = ShootDuration
	Health = MaxHealth
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	HPBar.value_1 = Health * 100 / MaxHealth
	
	TailsCheck()
	ChangeTailsState()
	move()
	BossState()
	
	if (!canBeHurt):
		Health = MaxHealth
	else :
		HPBar.visible = true
		
		
	if (Health <= 0):
		SM = ShootMode.Die
		isDead = true
		
	move_and_slide()
	
func move():
	velocity = move_direction.direction * move_speed
			
func add_tails():
	if (tails.size() < 6):
		var new_tail = tail.instantiate()
		new_tail.position = spawnLocation
		new_tail.move_speed = move_speed
		new_tail.group_name = group_name
		get_parent().add_child(new_tail)
		new_tail.add_to_group("Enemies")
		tails.append(new_tail)	
	#print_debug(tails)

func _on_tail_generate_timer_timeout():
	add_tails()
	
	
func BossState():
	match (SM):
		ShootMode.SM1:
			pass
		ShootMode.SM2:
			move_speed = 150
			ChangeTailsMoveSpeed(move_speed)
			pass
		ShootMode.Mad:
			pass
		ShootMode.Weak:
			canBeHurt = true
			move_speed = 100
			if (shooterCalmDown):
				ShootTimer.start()
				shooterCalmDown = false
			ChangeTailsMoveSpeed(move_speed)
			pass
		ShootMode.Die:
			ShootTimer.stop()
			move_speed = 0
			ChangeTailsMoveSpeed(move_speed)
			pass

func ChangeTailsMoveSpeed(move_speed):
	if (tails != null):
		for i in tails:
			i.move_speed = move_speed
			
func TailsCheck():
	if (tails != null && !isWeak):
		var diedTailCount = 0
		# 查看Tail中的死亡数量
		for i in tails:
			if (i.SM == i.ShootMode.Die):
				diedTailCount += 1
		#print_debug(diedTailCount)
		# Tail死亡超过两个，进入状态2
		if (diedTailCount >= 2):
			SM = ShootMode.SM2
			#print_debug(SM)
		# Tail死亡超过四个，进入癫狂状态
		if (diedTailCount >= 4):
			SM = ShootMode.Mad
			#print_debug(SM)
		# Tail全部死亡，进入虚弱状态
		if (diedTailCount == 6):
			SM = ShootMode.Weak
			isWeak = true
			#print_debug(SM)
			
func ChangeTailsState():
	if (tails != null):
		for i in tails:
			if (SM == ShootMode.SM1):
				i.SM = i.ShootMode.SM1
			if (SM == ShootMode.SM2):
				i.SM = i.ShootMode.SM2
			if (SM == ShootMode.Mad):
				i.SM = i.ShootMode.Mad


func _EnemyDetection():
	pass
	
func _BossDetection():
	pass


func _on_shoot_timer_timeout():
	ShootBullets()
	shooterCalmDown = true
	pass # Replace with function body.

func ShootBullets():
	for i in bulletSpawners:
		var bullet = Bullet.instantiate()
		get_parent().add_child(bullet)
		var bulletDirection = (i.global_position - global_position).normalized()

		bullet.position = i.global_position
		bullet.rotation = atan2(bulletDirection.x,bulletDirection.y)
		bullet.MoveDirection = bulletDirection
