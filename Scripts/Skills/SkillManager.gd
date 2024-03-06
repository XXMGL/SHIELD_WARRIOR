extends Node

var player
var skills_Pool:Array
var skills : Array#Legendary Skills pool
var skills_B:Array#Blue Skills pool
var skills_G:Array#Green SKills pool
var Skills_legendary : Array
#@onready var Skill1 = preload("res://TSCN/Player/Skills/shards_shoot_skills.tscn")
@onready var Skill1 = $ShardsShootSkills
@onready var Skill2 = $Reposition
@onready var Skill3 = $Wing_Man
@onready var Skill4 = $Resilient_Heart

@onready var B_Skill1 = $Guardian_Shield
@onready var B_Skill2 = $Mystic_Familiar

var skills_rarity_index:int = 0
# Called when the node enters the scene tree for the first time.
#signals
signal B_Skill1_up
signal B_Skill2_up
func _ready():
	#player = get_tree().get_nodes_in_group("Player")
	#skills.append(Skill1)
	#skills.append(Skill2)
	#skills.append(Skill3)
	#skills.append(Skill4)
	_Get_Skills("Legendary", skills)
	_Get_Skills("Blue", skills_B)
	skills_Pool = skills_B
	#print_debug(skills_Pool)
	activate_skill(1)
	activate_skill(1)
	#skills = []
	#Skill3.activate()
	pass # Replace with function body.


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
		skills_Pool = skills
	elif index == 1:
		skills_Pool = skills_B
	elif index == 2:
		skills_Pool = skills_G
