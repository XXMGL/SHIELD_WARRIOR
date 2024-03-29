extends Node

var levelNum = 0
#var Bulllet_ac = [1,1.5,3]
var MaxLevel = 3
var Name = "Guardian Shield"
var Rarity = "Rare"
var Skill_index = 0
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 1
var branch_size:int = 1

func _ready():
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))

func activate():
	SkillManager.emit_signal("B_Skill1_up")
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		var Slot_in_Scene = get_tree().get_nodes_in_group("Shield_Slot")
		if Slot_in_Scene.size()<1:
			var Slot_tscn = load("res://TSCN/UI/Guardian_Shield_Slot.tscn")
			var new_Slot = Slot_tscn.instantiate()
			get_parent().add_child(new_Slot)
			new_Slot.Skill_Level = levelNum
	pass
	
func deactivate():
	levelNum = 0
	isFullLv = false
	pass
	
