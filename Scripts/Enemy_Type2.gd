extends CharacterBody2D

@export var move_speed = 100  
@export var wander_direction : Node2D
@export var group_name : String

var bullet_tscn = preload("res://TSCN/bullet_2.tscn")
@export var ShootDuration = 2.0
var Shoot_timer = 0.0



func _ready():
	pass

func _physics_process(delta):
	velocity = wander_direction.direction * move_speed
	move_and_slide()	
	
	Shoot_timer += delta
	if Shoot_timer >= ShootDuration:
		_ShootBullet()
		Shoot_timer = 0
	else:
		pass
	
	

func _ShootBullet():
	var bullet = bullet_tscn.instantiate()
	get_parent().add_child(bullet)
	bullet.position = get_node("BulletSpawner").global_position
	
func _EnemyDetection():
	pass

