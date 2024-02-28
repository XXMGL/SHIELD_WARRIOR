extends CanvasLayer

@export var ShuffleChance = 1
var Buttons = []
@onready var Button1 = $HBoxContainer/Button
@onready var Button2 = $HBoxContainer/Button2
@onready var Button3 = $HBoxContainer/Button3
@onready var ShuffleButton = $Shuffle
@onready var ShuffleChance_Text = $Shuffle/ShuffleC

#var SkillManager = preload("res://TSCN/Player/SkillManager.tscn")

var skillsPool = []
var indexRange = []

func _ready():
	ShuffleChance_Text.text = str(ShuffleChance)
	_Shuffle()
	pass
	


func _Shuffle():
	skillsPool = SkillManager.skills
	_GetRandomSkill(Button1)
	_GetRandomSkill(Button2)
	_GetRandomSkill(Button3)
	pass
	
func _GetRandomSkill(Button):	
	var randomNum = randi_range(0,skillsPool.size()-1)
	while randomNum in indexRange:
		randomNum = randi_range(0,skillsPool.size()-1)
	Button.Skillindex = randomNum
	indexRange.append(randomNum)
	pass

func _on_shuffle_pressed():
	#if ShuffleChance >0:
	indexRange = []
	_Shuffle()
	ShuffleChance -= 1
	ShuffleChance_Text.text = str(ShuffleChance)
	if ShuffleChance <= 0:
		ShuffleButton.disabled = true
		
	pass # Replace with function body.
