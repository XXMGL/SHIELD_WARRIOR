extends Node

var player
var skills_Pool:Array
var skills : Array#Legendary Skills pool
var skills_B:Array#Blue Skills pool
var skills_G:Array#Green SKills pool
var skills_legendary:Array#Legendary Skills pool
var skills_Available:Array

@onready var Skill1 = $ShardsShootSkills
@onready var Skill2 = $Reposition
@onready var Skill3 = $Wing_Man
@onready var Skill4 = $Resilient_Heart

@onready var B_Skill1 = $Guardian_Shield
@onready var B_Skill2 = $Mystic_Familiar

var skills_rarity_index:int = 0

#Skills Branches
signal B_Skill2_1

#signals
signal G_Skill1_up
signal B_Skill1_up
signal B_Skill2_up

signal Lv_up_Refresh

signal DeactiveAllSkills

func _ready():
	connect("Lv_up_Refresh",Callable(self,"_Get_Availabel_Skills"))
	#player = get_tree().get_nodes_in_group("Player")
	_Get_Skills("Legendary", skills_legendary)
	_Get_Skills("Rare", skills_B)
	_Get_Skills("Normal", skills_G)
	skills_Pool = skills_G
	
	
	_Get_Availabel_Skills()



func activate_skill(skill_index):
	skills_Pool[skill_index].activate()

func deactivate_skill(skill_index):
	skills_Pool[skill_index].deactivate()

	
	
func _get_Names():
	#Name = Skill.Name
	pass

func _Get_Skills(Skills_Class, Skills_Array):
	var Skills = get_tree().get_nodes_in_group(Skills_Class)
	#print_debug(Skills)
	for skill in Skills:
		Skills_Array.append(skill)

func _Set_Skill_Pool(index):
	if index == 0:
		skills_Pool = skills_legendary
	elif index == 1:
		skills_Pool = skills_B
	elif index == 2:
		skills_Pool = skills_G
		
func _Set_branch_index(skill,index):
	skill.branch_index = index
	pass

func _Get_branch_index(skill):
	return skill.branch_index

func _Get_Skill_has_branch(skill):
	return skill.has_branch
	
func _Get_brach_size(skill):
	return skill.branch_size
	
func _Get_Availabel_Skills():
	skills_Available = []
	var SM_skills = get_tree().get_nodes_in_group("SkillManager_skills")
	for skill in SM_skills:
		if skill.isFullLv == false:
			skills_Available.append(skill)
	#print_debug("Available Skills number: ",skills_Available.size())
	pass
	
func _Get_Activate_Skills(index):
	skills_Available = []
	var SM_skills = get_tree().get_nodes_in_group("SkillManager_skills")
	for skill in SM_skills:
		if skill.levelNum > 0 and skill.is_Displaying == false:
			skills_Available.append(skill)
			#skill.is_Displaying = true
	if skills_Available.size() != 0:
		var skills_info = {"size":skills_Available.size(),"skill":skills_Available[index]}
		return skills_info
	else:
		return {"size":skills_Available.size(),"skill":null}
	pass
