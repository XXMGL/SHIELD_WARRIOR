extends Button


var Sk_Layout1 = preload("res://ART Assets/SkillCardBG/Normal.png")
var Sk_Layout2 = preload("res://ART Assets/SkillCardBG/Rare.png")
var Sk_Layout3 = preload("res://ART Assets/SkillCardBG/Legendary.png")

var Sk_Icon1 = preload("res://ART Assets/300ppi/012.png")
var Sk_Icon2 = preload("res://ART Assets/300ppi/011.png")
var Sk_Icon3 = preload("res://ART Assets/300ppi/009.png")
var Sk_Icon4 = preload("res://ART Assets/300ppi/010.png")
var Sk_Icon5 = preload("res://ART Assets/ShieldSkill/1.png")

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
	#_Set_Skills_Layout()

func _process(delta):
	#_update_Skill_info()
	#_SetSkillInterface()
	pass

		
func _SetSkillInterface():
	if Skillindex == 0 and Rarity_index == 0:
		Skill = SK.skill1
	elif Skillindex == 1 and Rarity_index == 0:
		Skill = SK.skill2
	elif Skillindex == 2 and Rarity_index == 0:
		Skill = SK.skill3
	elif Skillindex == 3 and Rarity_index == 0:
		Skill = SK.skill4
	elif Skillindex == 0 and Rarity_index == 1:
		Skill = SK.B_skill1
	elif Skillindex == 1 and Rarity_index == 1:
		Skill = SK.B_skill2
	
	_Set_Skills_Layout()
		
func _Set_Skills_Layout():
	match Skill:
		SK.skill1:
			Layout.texture = Sk_Layout3
			Icon.texture = Sk_Icon1
			SkillName.text = "Shards Shoot"
			pass
		SK.skill2:
			Layout.texture = Sk_Layout3
			Icon.texture = Sk_Icon2
			SkillName.text = "Retargeting Bullet"
			pass
		SK.skill3:
			Layout.texture = Sk_Layout3
			Icon.texture = Sk_Icon3
			SkillName.text = "Wingman"
			pass
		SK.skill4:
			Layout.texture = Sk_Layout2
			Icon.texture = Sk_Icon4
			SkillName.text = "Resilient Heart"
			pass
		SK.B_skill1:
			Layout.texture = Sk_Layout2
			Icon.texture = Sk_Icon4
			SkillName.text = "Guardian Heart"
		SK.B_skill2:
			Layout.texture = Sk_Layout2
			if Branch_index == 1:	
				Icon.texture = Sk_Icon4
				SkillName.text = "Mystic Familiar_1"
			elif Branch_index == 2:
				Icon.texture = Sk_Icon3
				SkillName.text = "Mystic Familiar_2"
			elif Branch_index == 0:
				Icon.texture = Sk_Icon4
				SkillName.text = "Mystic Familiar"
			else:
				Icon.texture = Sk_Icon2
				SkillName.text = "Error"

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
	#print_debug("Rarity: ", Rarity_index)
	var skill_pool = Skills_info.skill_data[Rarity]
	var skillName = skill_pool.keys()[Skillindex]
	var Lv = "LV"+str(SkillManager.skills_Pool[Skillindex].levelNum+1)
	SkillName.text = skillName
	#print_debug(skill_pool[skillName]["LV1"].values()[0])
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
	
