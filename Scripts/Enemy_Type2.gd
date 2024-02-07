extends CharacterBody2D

@export var move_speed = 100  # 在x方向的移动速度
var enemy_velocity;
var timer = 0.0

var bullet_tscn = preload("res://TSCN/bullet_2.tscn")
@export var ShootDuration = 2.0
var Shoot_timer = 0.0


func _ready():
	pass


func _process(delta):
	Shoot_timer += delta
	if Shoot_timer >= ShootDuration:
		_ShootBullet()
		Shoot_timer = 0
	else:
		pass

	move_and_slide()	
	

func _ShootBullet():
	var bullet = bullet_tscn.instantiate()
	get_parent().add_child(bullet)
	bullet.position = get_node("BulletSpawner").global_position
