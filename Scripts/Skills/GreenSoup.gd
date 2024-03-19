extends Node

var levelNum = 0
var MaxLevel = 5
var Name = "Green Soup"
var Rarity = "Normal"
var Skill_index = 4
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
	#levelNum = 1
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		CharacterData.G_Skill5_Active_Lv1 = true
	elif levelNum == 2:
		CharacterData.G_Skill5_Active_Lv2 = true
	elif levelNum == 3:
		CharacterData.G_Skill5_Active_Lv3 = true
		var P_Aura = load("res://TSCN/Player/Skills/Poisonous_Aura.tscn")
		var P_A = P_Aura.instantiate()
		var Player = get_tree().get_first_node_in_group("Player")
		get_parent().add_child(P_A)
		P_A.Target = Player
	elif levelNum == 4:
		CharacterData.G_Skill5_Active_Lv4 = true
	elif levelNum == 5:
		CharacterData.G_Skill5_Active_Lv5 = true
		CharacterData.emit_signal("G_Skill5_Change_Target")

		pass
	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	CharacterData.G_Skill5_Active_Lv1 = false
	CharacterData.G_Skill5_Active_Lv2 = false
	CharacterData.G_Skill5_Active_Lv3 = false
	CharacterData.G_Skill5_Active_Lv4 = false
	CharacterData.G_Skill4_Active_Lv5 = false
	pass
