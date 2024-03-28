extends Node2D

#玩家生命值与体力条
@export var Basic_health = 100
@export var Basic_stamina = 100
@export var stamina_Cousume = 20
@export var stamina_Recover = 10
var Basic_movespeed = 200
var Max_stamina

var Bullet_Bounce_Times = 0
var Bullet_Exist_Time = 5

var LevelNum = 1
var Exp = 0
var Exp_to_NextLevel = 20 # 杜亦然调整经验值 60-》20

#signal
signal  EnemyDie

#1.2 Bubble Gun
var B_Skill3_Active_Lv1:bool = false
var B_Skill3_Active_Lv2:bool = false
var B_Skill3_Active_Lv3:bool = false
var B_Skill3_Active_Lv4:bool = false
var B_Skill3_Branch_index = 1

#2.3 Sapling
var G_Skill4_Active_Lv1:bool = false
var G_Skill4_Active_Lv2:bool = false
var G_Skill4_Active_Lv3:bool = false
var G_Skill4_Active_Lv4:bool = false
var G_Skill4_Active_Lv5:bool = false
var G_Skill4_Branch = 1
var G_Skill4_Kill_Amount_Lv2 = 0
var G_Skill4_Kill_Amount_Lv3 = 60
@onready var G_Skill4_Timer = $G_Skill4_Timer

#2.4 Green Soup
var G_Skill5_Active_Lv1:bool = false
var G_Skill5_Active_Lv2:bool = false
var G_Skill5_Active_Lv3:bool = false
var G_Skill5_Active_Lv4:bool = false
var G_Skill5_Active_Lv5:bool = false
signal Pick_Up_Item
signal G_Skill5_Change_Target

func _ready():
	connect("EnemyDie",Callable(self,"G_Skill4_Count"))
	#print_debug("B_Skill3_Active_Lv1 : ",B_Skill3_Active_Lv1, "B_Skill3_Active_Lv2 : ",B_Skill3_Active_Lv2,"B_Skill3_Active_Lv3 : ",B_Skill3_Active_Lv3,"B_Skill3_Active_Lv4 : ",B_Skill3_Active_Lv4)

func G_Skill4_Acive():
	if G_Skill4_Active_Lv1 == true:
		pass
	if G_Skill4_Active_Lv2 == true:
		if G_Skill4_Kill_Amount_Lv2 >= 10:
			var HealingOrb = load("res://TSCN/Player/Skills/healing_orb.tscn")
			var HO = HealingOrb.instantiate()
			get_parent().call_deferred("add_child", HO)
			HO.global_position = $G_Skill4.global_position
			G_Skill4_Kill_Amount_Lv2 = 0
	if G_Skill4_Active_Lv3 == true:
		if G_Skill4_Kill_Amount_Lv3 >= 60 and G_Skill4_Branch == 1:
			G_Skill4_Branch = 2
			LevelManager.Level_up_Interface(10,1,1)	
			Character.stamina_Cousume = stamina_Cousume
		pass
	if G_Skill4_Active_Lv4 == true and G_Skill4_Branch == 2:
		var Enemies = get_tree().get_nodes_in_group("Enemies")
		for Enemy in Enemies:
			if Enemy.has_method("_EnemyDetection"):
				Enemy.Health -= 0.2
				#print_debug(Enemy.Health)
		pass
	if G_Skill4_Active_Lv5 == true and G_Skill4_Branch == 2:
		var Enemies = get_tree().get_nodes_in_group("Enemies")
		for Enemy in Enemies:
			if Enemy.has_method("_EnemyDetection"):
				#print_debug(Enemy.move_speed)
				if Enemy.G_Skill4_Slow == false:
					Enemy.move_speed *= 0.7
					Enemy.G_Skill4_Slow = true
					print_debug(Enemy.move_speed)
		pass
		
		
func G_Skill4_Count():
	if G_Skill4_Active_Lv2 == true:
		G_Skill4_Kill_Amount_Lv2 +=1
	if G_Skill4_Active_Lv3 == true and G_Skill4_Branch == 1:
		G_Skill4_Kill_Amount_Lv3 +=1



func _on_g_skill_4_timer_timeout():
	G_Skill4_Acive()
	pass # Replace with function body.
	
