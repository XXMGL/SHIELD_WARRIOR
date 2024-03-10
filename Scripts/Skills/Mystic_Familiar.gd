extends Node

var levelNum = 0
var MaxLevel = 5
var Name = "Mystic_Familiar"
var weight = 2 #The possibility of this skill appearing in the upgrade interface has been determined.
@export var isFullLv = false #it will turn to ture if the skill is full level.
var is_Displaying = false #it will turn to true if the skill is on level_up interface
# skills branches
var has_branch:bool = false
var branch_index:int = 1
var branch_size:int = 2

var Mystic_Familiar
#skill at full level wont appear in the skill pool

func activate():
	SkillManager.emit_signal("B_Skill2_up")
	if levelNum < MaxLevel:
		levelNum += 1
	if levelNum >= MaxLevel:
		isFullLv = true
	if levelNum == 1:
		var MF = load("res://TSCN/Player/Skills/mystic_familiar.tscn")
		var Added_MF = MF.instantiate()
		var player = get_tree().get_first_node_in_group("Player")
		player.add_child(Added_MF)
		Added_MF.Skill_Lv = levelNum
		Mystic_Familiar = Added_MF
	if levelNum == 3:
		has_branch = true
	if levelNum == 4:
		has_branch = false

	pass
	#print_debug(Mystic_Familiar.branch_index)
	
func deactivate():

	pass
	
