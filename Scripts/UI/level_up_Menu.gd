extends CanvasLayer

@export var ShuffleChance = 1
var Buttons = []
@onready var Button1 = $HBoxContainer/Skill1
@onready var Button2 = $HBoxContainer/Skill2
@onready var Button3 = $HBoxContainer/Skill3
@onready var ShuffleButton = $Shuffle
@onready var ShuffleChance_Text = $Shuffle/ShuffleC
var skill_index

var skillsPool = []

#skills rarity control
var skills_rarity_index:int = 0
@export var skills_L_weight = 5
@export var skills_B_weight = 5
@export var skills_G_weight = 2

func _ready():
	ShuffleChance_Text.text = str(ShuffleChance)
	_Shuffle()
	pass
# Shuffling the upgrading choices
func _Shuffle():
	skillsPool = []
	_Set_Skill(Button1,0)
	_Set_Skill(Button2,1)
	_Set_Skill(Button3,2)
	SkillManager.emit_signal("Lv_up_Refresh")
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
	#print_debug("skillsPool size: ",skillsPool.size(), "skillsPool: ",skillsPool)
	pass
	
func _Check_Skill_Branches(Button,index):
	if SkillManager._Get_Skill_has_branch(skillsPool[index]) == true:
		var randomindex = randi_range(1,SkillManager._Get_brach_size(skillsPool[index]))
		SkillManager._Set_branch_index(skillsPool[index],randomindex)
		Button.Branch_index = randomindex
	else:
		Button.Branch_index = SkillManager._Get_branch_index(skillsPool[index])
	
func _GetRandomSkill(Button):
	_Set_SkillsPool()
	var weightedIndexes = []  # 存储带有权重的索引	
	skill_index = 0
	# 根据权重向列表中添加相应的索引 # add index to the array with the weight of the skill
	for i in range(skillsPool.size()):
		for j in range(skillsPool[i].weight):
			weightedIndexes.append(i)
	# choose a skill index depends on the weight of the skill
	var randomIndex = weightedIndexes[randi() % weightedIndexes.size()] 
	skill_index = randomIndex
	_Check_Skill_Branches(Button,randomIndex)
	Button.Skillindex = skill_index
	Button.Rarity_index = skills_rarity_index
	#print_debug(Button.Skillindex,",",Button.Rarity_index)
	pass
	
func _Set_Skill(Button,i):
	_GetRandomSkill(Button)
	#if SkillManager.skills_Available.size()>=1:
	while SkillManager.skills_Pool[skill_index].isFullLv == true:
		_GetRandomSkill(Button)
		#print_debug(SkillManager.skills_Pool[skill_index].isFullLv)
	if SkillManager.skills_Available.size()>=3:
		var Skills = get_tree().get_nodes_in_group("Skills_Button")
		Skills.remove_at(i)
		var Skills_index = []
		var Button_index = [Button.Rarity_index,Button.Skillindex,Button.Branch_index]
		for j in Skills.size():
			var index = [Skills[j].Rarity_index,Skills[j].Skillindex,Skills[j].Branch_index]
			Skills_index.append(index)
		while Button_index in Skills_index or SkillManager.skills_Pool[skill_index].isFullLv == true:
			_GetRandomSkill(Button)
			Button_index = [Button.Rarity_index,Button.Skillindex,Button.Branch_index]



func _on_shuffle_pressed():
	_Shuffle()
	ShuffleChance -= 1
	ShuffleChance_Text.text = str(ShuffleChance)
	if ShuffleChance <= 0:
		ShuffleButton.disabled = true
		
	pass # Replace with function body.
