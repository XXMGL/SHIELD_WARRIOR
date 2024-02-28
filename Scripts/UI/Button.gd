extends Button

@onready var SkillName = $LineEdit

var Sk_Layout1 = preload("res://ART Assets/Level_1_templete.png")
var Sk_Layout2 = preload("res://ART Assets/Level_2_templete.png")

enum SK{skill1,skill2,skill3}
@export var Skill = SK.skill1
var Skillindex

# Called when the node enters the scene tree for the first time.
func _ready():
	var Layout = get_child(0)
	match Skill:
		SK.skill1:
			Layout.texture = Sk_Layout1
			SkillName.text = "Shards Shoot"
			pass
		SK.skill2:
			Layout.texture = Sk_Layout2
			SkillName.text = "Retargeting Bullet"
			pass
		SK.skill3:
			Layout.texture = Sk_Layout1
			SkillName.text = "Wingman"
			pass

func _process(delta):
	_SetSkillByIndex()
	_SetSkillInterface()


func _SetSkillByIndex():
	if Skillindex == 0:
		Skill = SK.skill1
	elif Skillindex == 1:
		Skill = SK.skill2
	elif Skillindex == 2:
		Skill = SK.skill3
		
func _SetSkillInterface():
	var Layout = get_child(0)
	match Skill:
		SK.skill1:
			Layout.texture = Sk_Layout1
			SkillName.text = "Shards Shoot"
			pass
		SK.skill2:
			Layout.texture = Sk_Layout2
			SkillName.text = "Retargeting Bullet"
			pass
		SK.skill3:
			Layout.texture = Sk_Layout1
			SkillName.text = "Wingman"
			pass
		





