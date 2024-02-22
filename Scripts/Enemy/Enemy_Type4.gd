extends CharacterBody2D

@export var move_speed = 100  
@export var wander_direction : Node2D
@export var group_name : String

@export var bullet_spawner1 = "bullet_spawner_1"
@export var bullet_spawner2 = "bullet_spawner_2"

var bullet_tscn = preload("res://TSCN/Bullet/bullet_2.tscn")
@export var ShootDuration = 0.15
var Shoot_timer = 0.0

@export var Health = 1


func _ready():
	pass

func _physics_process(delta):
	rotate(0.3)
	
	
	velocity = wander_direction.direction * move_speed
	move_and_slide()	
	
	
	Shoot_timer += delta
	if Shoot_timer >= ShootDuration:
		_ShootBullet()
		Shoot_timer = 0
	else:
		pass
	
	

func _ShootBullet():
	var bullet1 = bullet_tscn.instantiate()
	get_parent().add_child(bullet1)
	var bullet1Direction = (get_node(bullet_spawner1).global_position - global_position).normalized()
	bullet1.position = get_node(bullet_spawner1).global_position
	bullet1.rotation = atan2(bullet1Direction.x, bullet1Direction.y)
	bullet1.MoveDirection = bullet1Direction
	
	
	var bullet2= bullet_tscn.instantiate()
	get_parent().add_child(bullet2)
	var bullet2Direction = (get_node(bullet_spawner2).global_position - global_position ).normalized()
	bullet2.position = get_node(bullet_spawner2).global_position
	bullet2.rotation = atan2(bullet2Direction.x, bullet2Direction.y)
	bullet2.MoveDirection = bullet2Direction
	
func _EnemyDetection():
	pass



func _on_bullet_spawner_body_entered(body):
	pass

func _change_route(routeName):
	group_name = routeName
	emit_signal("Route_Change_Signal")
	
