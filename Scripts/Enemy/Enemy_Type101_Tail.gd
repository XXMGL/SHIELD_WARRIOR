extends CharacterBody2D

@onready var Bullet = preload("res://TSCN/Bullet/bullet_2.tscn")
@onready var ShootTimer = $ShootTimer

@onready var bulletSpawner1 = $BulletSpawner1
@onready var bulletSpawner2 = $BulletSpawner2
@onready var bulletSpawner3 = $BulletSpawner3
@onready var bulletSpawner4 = $BulletSpawner4

enum ShootMode{SM1,SM2,Mad}
@export var SM = ShootMode.SM1

var move_speed = 100
@export var move_direction = Node2D
var group_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = move_direction.direction * move_speed
	
	BossState()
	
	move_and_slide()
	

func BossState():
	match (SM):
		ShootMode.SM1:
			pass
		ShootMode.SM2:
			var rotateSpeed = 0.2
			var rotateDir=0
			
			print_debug(bulletSpawner4.rotation_degrees)
			if (bulletSpawner4.rotation_degrees >= 180):
				rotateDir = -1
			elif(bulletSpawner4.rotation_degrees <= 0):
				rotateDir = 1
			
			bulletSpawner4.rotation += rotateSpeed * rotateDir

			pass
		ShootMode.Mad:
			pass

func ShootBullet():
	match (SM):
		ShootMode.SM1:
			pass
		ShootMode.SM2:
			var bullet = Bullet.instantiate()
			get_parent().add_child(bullet)
			var bulletDirection = (get_node("BulletSpawner4/ShootDirection").global_position - get_node("BulletSpawner4").global_position).normalized()

			bullet.position = get_node("BulletSpawner4").global_position
			bullet.rotation = atan2(bulletDirection.x,bulletDirection.y)
			bullet.MoveDirection = bulletDirection
			
			pass
		ShootMode.Mad:
			pass



func _on_shoot_timer_timeout():
	ShootBullet()
