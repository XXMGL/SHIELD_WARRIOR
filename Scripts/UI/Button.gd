extends Button

@onready var SkillName = $Layout/Skill/SkillName
@onready var Lv_Num = $Layout/Skill/Lv_Num
@onready var SkillContent = $Layout/Skill/SkillContent
@onready var Layout = $Layout
@onready var Icon = $Layout/icon
@onready var SkillContent2 = $Layout/Skill/SkillContent2


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
	var Next_Lv = "LV"+str(SkillManager.skills_Pool[Skillindex].levelNum+2)
	var SkillContent_CurrentLv = skill_pool[skillName][Lv].values()[Branch_index - 1]
	var SkillContent_NextLv = "Lv Max"
	if SkillManager.skills_Pool[Skillindex].levelNum+2 <= SkillManager.skills_Pool[Skillindex].MaxLevel:	
		SkillContent_NextLv = skill_pool[skillName][Next_Lv].values()[Branch_index - 1]
	#print_debug("Skill Name: ",skillName, "Skill Lv: ", Lv)
	SkillName.text = skillName
	Lv_Num.text = skill_pool[skillName][Lv].keys()[Branch_index - 1]
	SkillContent.text = str(SkillContent_CurrentLv)#+"\n\n"+"Next Level:"+"\n"+ str(SkillContent_NextLv)
	SkillContent2.text = str(SkillContent_NextLv)
	#SkillContent.append_text(str(SkillContent_CurrentLv)+"\n\n"+"[color=gray][b][i]Next Level:[/i][/b][/color]"+"\n"+ "[color=gray]%s[/color]"%str(SkillContent_NextLv))
	#SkillContent.text = "11"
	Layout.texture = load("res://ART Assets/SkillCardBG/"+Rarity+".png")
	Icon.texture = load("res://ART Assets/Skills Icons/"+skillName+".png")
	#print_debug(Skillindex)
	pass


func _on_pressed():
	Bgm.emit_signal("ButtonClick")
	SkillManager._Set_Skill_Pool(Rarity_index)
	SkillManager._Set_branch_index(SkillManager.skills_Pool[Skillindex],Branch_index)
	SkillManager.activate_skill(Skillindex)
	get_tree().paused = false
	get_parent().get_parent().queue_free()
	pass # Replace with function body.
	
