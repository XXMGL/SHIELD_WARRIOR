extends CharacterBody2D

var x_direction = 1
var x_velocity
var y_direction = 1
var y_velocity

@export var move_speed = 200  # 在x方向的移动速度

enum Origin{From_Enemy, From_Player}
@export var OriginFrom = Origin.From_Enemy

@export var Damage = 10

func _ready():
	pass
	
func _process(delta):
	match OriginFrom:
		Origin.From_Enemy:
			x_direction = -1
			x_velocity = x_direction * move_speed
			velocity = Vector2(x_velocity,0)
			move_and_slide()	
			pass
		Origin.From_Player:
			x_direction = 1
			x_velocity = x_direction * move_speed
			velocity = Vector2(x_velocity,0)
			move_and_slide()	
			pass


func _on_detector_body_entered(body):
	if body.has_method("get_name") and body.get_name() == "Eage":
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Enemy and body.has_method("_CharacterDetection"):
		queue_free()  # 销毁子弹
	if OriginFrom == Origin.From_Player and body.has_method("_EnemyDetection"):
		queue_free()  # 销毁子弹
		
				
func _BulletDetection():
	return Damage
