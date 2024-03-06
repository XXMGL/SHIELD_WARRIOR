extends CanvasLayer

@export var ShuffleChance = 10
var Buttons = []
@onready var Button1 = $HBoxContainer/Skill1
@onready var Button2 = $HBoxContainer/Skill2
@onready var Button3 = $HBoxContainer/Skill3
@onready var ShuffleButton = $Shuffle
@onready var ShuffleChance_Text = $Shuffle/ShuffleC


var skillsPool = []
var indexRange = []

#skills rarity control
var skills_rarity_index:int = 0
@export var skills_L_weight = 5
@export var skills_B_weight = 5
@export var skills_G_weight = 0

func _ready():
	ShuffleChance_Text.text = str(ShuffleChance)
	_Shuffle()
	pass
	

# Shuffling the upgrading choices
func _Shuffle():
	skillsPool = []
	#for skill in SkillManager.skills:
		#if skill.isFullLv == false:
			#skillsPool.append(skill)
	_GetRandomSkill(Button1)
	_GetRandomSkill(Button2)
	_GetRandomSkill(Button3)
	pass

func _Set_SkillsPool():
	var skills_weight_array = [skills_L_weight,skills_B_weight,skills_G_weight]
	var Rarity_Indexes = []
	for i in range(3):
		for j in range(skills_weight_array[i]):
			Rarity_Indexes.append(i)
			pass
	var randomIndex = Rarity_Indexes[randi() % Rarity_Indexes.size()] 
	skills_rarity_index = randomIndex
	SkillManager._Set_Skill_Pool(randomIndex)
	skillsPool = SkillManager.skills_Pool
	#print_debug(skillsPool)
	pass
	
func _GetRandomSkill(Button):
	_Set_SkillsPool()
	var weightedIndexes = []  # 存储带有权重的索引	
	# 根据权重向列表中添加相应的索引 # add index to the array with the weight of the skill
	for i in range(skillsPool.size()):
		for j in range(skillsPool[i].weight):
			weightedIndexes.append(i)
	# choose a skill index depends on the weight of the skill
	var randomIndex = weightedIndexes[randi() % weightedIndexes.size()] 
	# choose another random index until the chosen index is not similar than the prvious choices
	while randomIndex in indexRange and skillsPool.size() >= 3:
		randomIndex = weightedIndexes[randi() % weightedIndexes.size()]
	indexRange.append(randomIndex)
	#print_debug(weightedIndexes)
	Button.Skillindex = randomIndex
	Button.Rarity_index = skills_rarity_index
	#print_debug(Button.Skillindex,",",Button.Rarity_index)
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
