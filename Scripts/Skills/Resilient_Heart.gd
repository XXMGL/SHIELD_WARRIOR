extends Node

var levelNum = 0
var MaxLevel = 3
var Hearts_Num = [3,4,4]
var Name = "Resilient Heart"
var Rarity = "Legendary"
var Skill_index = 3
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
	Character.HealthBar.visible = false
	Character.HeartNum = Hearts_Num[levelNum-1]
	Character._R_Heart()
		
	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	Character.HealthBar.visible = true
	pass
