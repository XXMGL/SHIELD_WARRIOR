extends CharacterBody2D

@export var move_speed = 100  
@export var wander_direction : Node2D
@export var group_name : String
@onready var EnemyAnimation = $AnimationPlayer

var bullet_tscn = preload("res://TSCN/Bullet/bullet_2.tscn")
@export var ShootDuration = 2.0
var Shoot_timer = 0.0

@export var Health = 1

signal Route_Change_Signal

func _ready():
	pass

func _physics_process(delta):
	EnemyAnimation.play("Fly")
	velocity = wander_direction.direction * move_speed
	move_and_slide()	
	
	Shoot_timer += delta
	if Shoot_timer >= ShootDuration:
		_ShootBullet()
		Shoot_timer = 0
	else:
		pass
		
	if Health <= 0:
		queue_free()  # 销毁
	
	

func _ShootBullet():
	var bullet = bullet_tscn.instantiate()
	get_parent().add_child(bullet)
	bullet.position = get_node("BulletSpawner").global_position
	
func _EnemyDetection():
	pass



func _on_bullet_spawner_body_entered(body):
	pass

func _change_route(routeName):
	group_name = routeName
	emit_signal("Route_Change_Signal")
	#$Wander.emit_signal("Route_Change_Signal")
