extends Node


var levelNum = 0
var MaxLevel = 4
var Name = "Bubble_Gun"
var Rarity = "Rare"
var Skill_index = 2
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 1
var branch_size:int = 2

var Mystic_Familiar
#skill at full level wont appear in the skill pool

func _ready():
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))

func activate():
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		CharacterData.B_Skill3_Active_Lv1 = true
		var Bubble_Generator = load("res://TSCN/Player/Skills/bubble_generator.tscn")
		var B_G = Bubble_Generator.instantiate()
		get_parent().add_child(B_G)
		pass
	if levelNum == 2:
		has_branch = true
		CharacterData.B_Skill3_Active_Lv2 = true
		CharacterData.B_Skill3_Branch_index = branch_index
		pass
	if levelNum == 3:
		has_branch = false
		CharacterData.B_Skill3_Active_Lv3 = true
		CharacterData.B_Skill3_Branch_index = branch_index
	if levelNum == 4:
		CharacterData.B_Skill3_Active_Lv4 = true
		pass

	pass
	#print_debug(Mystic_Familiar.branch_index)
	
func deactivate():
	levelNum = 0
	isFullLv = false
	has_branch = false
	CharacterData.B_Skill3_Active_Lv1 = true
	CharacterData.B_Skill3_Active_Lv2 = true
	CharacterData.B_Skill3_Active_Lv3 = true
	CharacterData.B_Skill3_Active_Lv4 = true
	pass
