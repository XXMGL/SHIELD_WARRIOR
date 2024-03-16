extends CharacterBody2D

@export var Offset = 100
var target: Node2D
var Skill_Lv = 0
@export var heal_continue = 3
@export var stamina_continue = 1

var heal_Count = 0

var is_Lv_1:bool = false
var is_Lv_2:bool = false
var is_Lv_3:bool = false
var is_Lv_4:bool = false
var is_Lv_5:bool = false

func _ready():
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))
	target = get_tree().get_first_node_in_group("Player")
	SkillManager.connect("G_Skill1_up",Callable(self,"_G_Skill1_up"))
	
	
func _process(_delta):
	if target:
		var target_position = target.global_position
		# 计算新位置
		var new_x = target_position.x - Offset
		var new_y = target_position.y - Offset
		# 移动到新位置
		global_position = Vector2(new_x, new_y)
	pass

func _G_Skill1_up():
	Skill_Lv += 1
	#print_debug(Skill_Lv)
	if Skill_Lv == 1:
		is_Lv_1 = true
		var heal_timer = $heal_timer
		heal_timer.start()
		pass
	elif Skill_Lv == 2:
		is_Lv_2 = true
		heal_continue *= 1.5
		pass
	elif Skill_Lv == 3:
		is_Lv_3 = true
		Character.stamina_Recover += 5
		pass
	elif Skill_Lv == 4:
		is_Lv_4 = true
		stamina_continue *= 1.5
		Character.stamina_Recover += 5
		pass
	elif Skill_Lv == 5:
		is_Lv_5 = true
		Character.connect("precise_Parry",Callable(self,"Burst_Heal"))
		pass
		
func _Heal(heal,stamina):
	if Character.Resilient_Heart_enabled == false:
		if Character.health < Character.Max_health:
			Character.health += heal
			if Character.health > Character.Max_health:
				Character.health = Character.Max_health
			pass
	elif Character.Resilient_Heart_enabled == true:
		heal_Count += 3
		if heal_Count >= 1:
			Character.emit_signal("heal")
			heal_Count = 0
		pass
	pass
	
func Burst_Heal():
	if Character.health < Character.Max_health:
		Character.health += 5
		if Character.health > Character.Max_health:
			Character.health = Character.Max_health
		pass
	if is_Lv_3 == true:
		if Character.stamina < Character.Max_stamina:
			Character.stamina += 3
			if Character.stamina > Character.Max_stamina:
				Character.stamina = Character.Max_stamina
	pass


func _on_heal_timer_timeout():
	_Heal(heal_continue,stamina_continue)
	pass # Replace with function body.
	
func deactivate():
	queue_free()
	pass
