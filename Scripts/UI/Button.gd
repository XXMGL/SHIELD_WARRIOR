extends Button

@onready var SkillName = $Layout/Skill/SkillName
@onready var SkillContent = $Layout/Skill/SkillContent
@onready var Layout = $Layout
@onready var Icon = $Layout/icon


enum SK{skill1,skill2,skill3,skill4,B_skill1,B_skill2}
@export var Skill = SK.skill1
var Skillindex
var Rarity_index
var Rarity
var Branch_index:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	SkillManager.connect("Lv_up_Refresh",Callable(self,"_update_Skill_info"))

func _process(delta):
	pass

func _set_Rarity():
	if Rarity_index == 0:
		Rarity = "Legendary"
	elif Rarity_index == 1:
		Rarity = "Rare"
	elif Rarity_index == 2:
		Rarity = "Normal"

func _update_Skill_info():
	_set_Rarity()
	SkillManager._Set_Skill_Pool(Rarity_index)
	var skill_pool = Skills_info.skill_data[Rarity]
	var skillName = skill_pool.keys()[Skillindex]
	var Lv = "LV"+str(SkillManager.skills_Pool[Skillindex].levelNum+1)
	#print_debug("Skill Name: ",skillName, "Skill Lv: ", Lv)
	SkillName.text = skillName +" "+ skill_pool[skillName][Lv].keys()[Branch_index - 1]
	SkillContent.text = skill_pool[skillName][Lv].values()[Branch_index - 1]
	Layout.texture = load("res://ART Assets/SkillCardBG/"+Rarity+".png")
	Icon.texture = load("res://ART Assets/Skills Icons/"+skillName+".png")
	pass


func _on_pressed():
	SkillManager._Set_Skill_Pool(Rarity_index)
	SkillManager._Set_branch_index(SkillManager.skills_Pool[Skillindex],Branch_index)
	SkillManager.activate_skill(Skillindex)
	get_tree().paused = false
	get_parent().get_parent().queue_free()
	pass # Replace with function body.
	
