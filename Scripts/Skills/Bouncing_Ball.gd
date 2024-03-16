extends Node

var levelNum = 0
var MaxLevel = 5
var Name = "BouncingBall"
var Rarity = "Normal"
var Skill_index = 1
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
		Character.G_Skill2_Active_Lv1 = true
	elif levelNum == 2:
		Character.G_Skill2_Active_Lv2 = true
	elif levelNum == 3:
		Character.Bullet_Bounce_Times = 1
	elif levelNum == 4:
		print_debug("11")
		Character.Bullet_Bounce_Times = 3
	elif levelNum == 5:
		Character.G_Skill2_Active_Lv5 = true
		pass
	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	Character.Bullet_Bounce_Times = 0
	Character.G_Skill2_Active_Lv1 = false
	Character.G_Skill2_Active_Lv2 = false
	Character.G_Skill2_Active_Lv5 = false
	pass
