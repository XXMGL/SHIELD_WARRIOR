extends Node

var levelNum = 0
var MaxLevel = 5
var Name = "Papper Airplane"
var Rarity = "Normal"
var Skill_index = 2
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
		Character.Bullet_Exist_Time *= 2
	elif levelNum == 2:
		Character.G_Skill3_Active_Lv2 = true
	elif levelNum == 3:
		Character.G_Skill3_Active_Lv3 = true
	elif levelNum == 4:
		Character.G_Skill3_Active_Lv4 = true
	elif levelNum == 5:
		Character.G_Skill3_Active_Lv5 = true
		pass
	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	Character.Bullet_Exist_Time = CharacterData.Bullet_Exist_Time
	Character.G_Skill3_Active_Lv2 = false
	Character.G_Skill3_Active_Lv3 = false
	Character.G_Skill3_Active_Lv4 = false
	Character.G_Skill3_Active_Lv5 = false
	pass

