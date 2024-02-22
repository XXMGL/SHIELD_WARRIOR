extends CharacterBody2D

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity

# @onready var BulletAnimation = $AnimationPlayer


@export var move_speed = 200  # 在x方向的移动速度

enum Origin{From_Enemy, From_Player}
@export var OriginFrom = Origin.From_Enemy
@export var Damage = 10

@export var canRunThrough = false
@export var Reposition = false
var Reposition_Timer = 0
var Reposition_Target:Node2D
var MoveDirection = Vector2(-1 , 0)

func _ready():
	pass
	
func _process(delta):            
	if OriginFrom == Origin.From_Player:
		#print_debug(global_position)
		pass
	
	match OriginFrom:
		Origin.From_Enemy:
			# BulletAnimation.play("shoot")
			pass
		Origin.From_Player:
			pass
	if Reposition == true:
		Reposition_Timer += delta
		if Reposition_Timer >= 0.5:
			#print_debug(Reposition_Target)
			if Reposition_Target != null:
				MoveDirection = (Reposition_Target.global_position - global_position).normalized()
				move_speed *= 1
	velocity = move_speed*MoveDirection
	move_and_slide()	


func _on_detector_body_entered(body):
	if body.has_method("get_name") and body.get_name() == "Eage":
		#print_debug("11")
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_CharacterDetection"):
		#print("11")
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_WingManDetection"):
		queue_free() # 销毁
	if OriginFrom == Origin.From_Player and body.has_method("_EnemyDetection"):
		#print_debug("11")
		body.Health -= Damage
		if canRunThrough:
			if body.has_method("_BossDetection"):
				queue_free()
			pass
		else:
			queue_free()  # 销毁子弹
		
				
func _BulletDetection():
	return Damage
