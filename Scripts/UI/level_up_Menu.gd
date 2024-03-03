extends CanvasLayer

@export var ShuffleChance = 10
var Buttons = []
@onready var Button1 = $HBoxContainer/Skill1
@onready var Button2 = $HBoxContainer/Skill2
@onready var Button3 = $HBoxContainer/Skill3
@onready var ShuffleButton = $Shuffle
@onready var ShuffleChance_Text = $Shuffle/ShuffleC

#var SkillManager = preload("res://TSCN/Player/SkillManager.tscn")

var skillsPool = []
var indexRange = []

func _ready():
	ShuffleChance_Text.text = str(ShuffleChance)
	_Shuffle()
	pass
	

# Shuffling the upgrading choices
func _Shuffle():
	#skillsPool = SkillManager.skills
	skillsPool = []
	for skill in SkillManager.skills:
		if skill.isFullLv == false:
			skillsPool.append(skill)
	#print_debug(skillsPool)
	_GetRandomSkill(Button1)
	_GetRandomSkill(Button2)
	_GetRandomSkill(Button3)
	pass
	
func _GetRandomSkill(Button):
	var weightedIndexes = []  # 存储带有权重的索引	
	# 根据权重向列表中添加相应的索引 # add index to the array with the weight of the skill
	for i in range(skillsPool.size()):
		for j in range(skillsPool[i].weight):
			weightedIndexes.append(i)
	# choose a skill index depends on the weight of the skill
	var randomIndex = weightedIndexes[randi() % weightedIndexes.size()] 
	# choose random index until the chosen index is not similar than the prvious choices
	while randomIndex in indexRange and skillsPool.size() >= 3:
		randomIndex = weightedIndexes[randi() % weightedIndexes.size()]
	indexRange.append(randomIndex)
	#print_debug(weightedIndexes)
	Button.Skillindex = randomIndex
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
