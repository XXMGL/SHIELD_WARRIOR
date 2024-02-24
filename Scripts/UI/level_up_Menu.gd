extends CanvasLayer

var Buttons = []
@onready var Button1 = $HBoxContainer/Button
@onready var Button2 = $HBoxContainer/Button2
@onready var Button3 = $HBoxContainer/Button3

#var SkillManager = preload("res://TSCN/Player/SkillManager.tscn")

var skillsPool = []

func _ready():
	_Shuffle()
	skillsPool = SkillManager.skills
	_GetRandomSkill(Button1)
	_GetRandomSkill(Button2)
	_GetRandomSkill(Button3)
	pass
	


func _Shuffle():
	pass
	
func _GetRandomSkill(Button):
	var randomNum = randi_range(0,skillsPool.size()-1)
	skillsPool.remove_at(randomNum)
	print_debug(skillsPool)
	Button.Skillindex = randomNum
	print_debug(Button.Skillindex)
	pass
