extends CharacterBody2D

#敌人基础数据
@export var move_speed = 100  
@export var Health = 1
@export var ShootDuration = 2.0
@export var wander_direction : Node2D
@export var group_name : String
@export var approach_speed = 50  # 在y轴上向玩家靠近的速度
#@export var player_root = "Character" # 玩家路径
var y_direction:int
var x_direction:int

@onready var EnemyAnimation = $AnimationPlayer

var bullet1_tscn = preload("res://TSCN/Bullet/bullet_1.tscn")
var bullet2_tscn = preload("res://TSCN/Bullet/bullet_2.tscn")
var Shoot_timer = 0.0

#敌人类型
enum Types {Enemy1, Enemy2, Enemy3, Enemy4}
@export var Enemy_type = Types.Enemy1

#Timer
var Move_Timer = 0.0
var Shoot_Timer = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	match Enemy_type:
		Types.Enemy1:
			pass
		Types.Enemy2:
			
			pass
		Types.Enemy3:
			pass
		Types.Enemy4:
			pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match Enemy_type:
		Types.Enemy1:
			EnemyAnimation.play("idle")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet(bullet1_tscn)
				Shoot_timer = 0
			pass
		Types.Enemy2:
			EnemyAnimation.play("Fly")
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet(bullet2_tscn)
				Shoot_timer = 0
			pass
		Types.Enemy3:
			pass
		Types.Enemy4:
			Shoot_timer += delta
			if Shoot_timer >= ShootDuration:
				_ShootBullet_Enemy4()
				Shoot_timer = 0
			pass
			
	if Health <= 0:
		queue_free()  # 销毁
	
func _physics_process(delta):
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
			pass
		Types.Enemy4:
			rotate(0.3)
			velocity = wander_direction.direction * move_speed
			pass
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
	
func _ShootBullet_Enemy4():
	var bullet1 = bullet2_tscn.instantiate()
	get_parent().add_child(bullet1)
	var bullet1Direction = (get_node("bullet_spawner_1").global_position - global_position).normalized()
	bullet1.position = get_node("bullet_spawner_1").global_position
	bullet1.rotation = atan2(bullet1Direction.x, bullet1Direction.y)
	#print_debug("bullet1Direction: ", bullet1Direction)
	bullet1.MoveDirection = bullet1Direction
	
	
	var bullet2= bullet2_tscn.instantiate()
	get_parent().add_child(bullet2)
	var bullet2Direction = (get_node("bullet_spawner_2").global_position - global_position ).normalized()
	bullet2.position = get_node("bullet_spawner_2").global_position
	bullet2.rotation = atan2(bullet2Direction.x, bullet2Direction.y)
	bullet2.MoveDirection = bullet2Direction
	
func _EnemyDetection():
	pass


func _on_bullet_spawner_body_entered(body):
	pass
	
func _change_route(routeName):
	group_name = routeName
