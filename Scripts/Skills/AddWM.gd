extends Node

var levelNum = 0
var MaxLevel = 3
var WM_Lv = [1,2,3]
var Name = "Wingman"
var Rarity = "Legendary"
var Skill_index = 2
var WingMan_tscn = preload("res://TSCN/Player/Skills/wing_man.tscn")
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 1
var branch_size:int = 1
#skill at full level wont appear in the skill pool

func _ready():
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))

func activate():
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		var newWM = WingMan_tscn.instantiate()
		var Player = get_tree().get_first_node_in_group("Player")
		Player.add_child(newWM)
	elif levelNum == 2:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv2 = true
	elif levelNum == 3:
		var WMs = get_tree().get_nodes_in_group("WM")
		for WM in WMs:
			WM.isLv3 = true
	#print_debug(levelNum)

	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	pass
