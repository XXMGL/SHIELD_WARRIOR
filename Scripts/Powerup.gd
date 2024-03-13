extends CharacterBody2D

var player

enum PowerupType {recover_life_value, raise_stamina_limit, increase_movement_speed}
@export var powerup_type = PowerupType.recover_life_value

@export var life_recovery_value = 50
@export var stamina_raise_value = 20
@export var movespeed_increase_value = 20

@export var wander_direction : Node2D
@export var group_name : String
@export var move_speed = 100 



func _ready():
	Tutorial.emit_signal("power_up_showing_up")
	LevelManager.connect("Final_Enemy_Die",Callable(self,"_self_Destroy"))
	
	player = get_tree().get_first_node_in_group("Player")
	if player.health == player.Max_health:
		var random_value = randi_range(0, 2)  # 生成0到2之间的随机整数
		if random_value == PowerupType.recover_life_value:
			random_value = randi_range(1, 2)  # 如果随机值是 recover_life_value，则重新生成随机数
		powerup_type = random_value
	else :
		var random_value = randi_range(0, 2)  # 生成0到2之间的随机整数
		powerup_type = random_value
	
	var sprite	
	if (powerup_type == PowerupType.recover_life_value):
		sprite = $Health
	elif (powerup_type == PowerupType.raise_stamina_limit):
		sprite = $Stamina
	elif (powerup_type == PowerupType.increase_movement_speed):
		sprite = $Speed
	sprite.visible = true


func _physics_process(_delta):
	velocity = wander_direction.direction * move_speed
	move_and_slide()
	pass
	


func _on_detector_body_entered(body):
	if body.has_method("_CharacterDetection"):
		ActivePowerupFunc(body)
		queue_free()

func ActivePowerupFunc(body):
	match powerup_type:
		PowerupType.recover_life_value:
			body.health += life_recovery_value
			if body.health > body.Max_health:
				body.health = body.Max_health
			#print_debug("玩家生命")
			pass
		PowerupType.raise_stamina_limit:
			body.Max_stamina += stamina_raise_value
			#print_debug("玩家精力上限")
			pass
		PowerupType.increase_movement_speed:
			body.MOVE_SPEED += movespeed_increase_value
			#print_debug("玩家玩家移速")
			pass
			
func _self_Destroy():
	queue_free()

