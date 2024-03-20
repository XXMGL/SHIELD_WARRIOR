extends Node

var Bubble = preload("res://TSCN/Player/Skills/bubble.tscn")

func _ready():
	Character.connect("parry",Callable(self,"Generate_Bubble"))
	Character.connect("precise_Parry",Callable(self,"Generate_Large_Bubble"))
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))




func Generate_Bubble():
	var Bu = Bubble.instantiate()
	call_deferred("add_child",Bu)
	#add_child(Bu)
	var Mouse_Pos = get_tree().get_first_node_in_group("Mouse_Pos")
	Bu.global_position = Mouse_Pos.global_position
	Bu.health = 1
	pass
	
func Generate_Large_Bubble():
	if CharacterData.B_Skill3_Active_Lv2 == true:
		var Bu = Bubble.instantiate()
		call_deferred("add_child",Bu)
		#add_child(Bu)
		var Mouse_Pos = get_tree().get_first_node_in_group("Mouse_Pos")
		Bu.global_position = Mouse_Pos.global_position
		Bu.scale = Vector2(3,3)
		Bu.Damage = 5
		Bu.health = 3
		Bu.bullet_Num = 15
	
func deactivate():
	queue_free()

