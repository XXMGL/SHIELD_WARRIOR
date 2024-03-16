extends Node

var levelNum = 0
var MaxLevel = 5
var Name = "Healbird"
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
	SkillManager.emit_signal("G_Skill1_up")
	#levelNum = 1
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		var HB = load("res://TSCN/Player/Skills/heal_bird.tscn")
		var Added_HB = HB.instantiate()
		var player = get_tree().get_first_node_in_group("Player")
		player.add_child(Added_HB)
		Added_HB.Skill_Lv = levelNum
	pass
	
func deactivate():

	pass
