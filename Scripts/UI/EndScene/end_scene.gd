extends CanvasLayer

@onready var Skills_Container = $Panel2/Skills_Container/BoxContainer
@onready var Level = $Level
@onready var PlayerLV = $PlayerLV
@onready var PlayerAnimator = $AnimatedSprite2D
var Skills_Icon = preload("res://TSCN/UI/End_Scene_Skill_Display.tscn")
var Skills_Size = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_HidePlayer()
	_Get_Skills_Size()
	_Set_Skills_Icons()
	_Set_PlayerLV()
	_Set_Level()
	PlayerAnimator.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _HidePlayer():
	Character.process_mode = Node.PROCESS_MODE_DISABLED
	Character.visible = false
	Character._hide_UI()

func _Get_Skills_Size():
	Skills_Size = SkillManager._Get_Activate_Skills(0).values()[0]
	pass
	
func _Set_Skills_Icons():
	for i in Skills_Size:
		var skill_i = SkillManager._Get_Activate_Skills(i).values()[1]
		var icon = Skills_Icon.instantiate()
		Skills_Container.add_child(icon)
		var Lv = "LV"+str(skill_i.levelNum)
		var Rarity = skill_i.Rarity
		var skill_pool = Skills_info.skill_data[Rarity]
		var skillName = skill_pool.keys()[skill_i.Skill_index]
		icon.BG_Skill.texture = load("res://ART Assets/Skills Icons/"+skillName+".png")
		icon.Skill_Lv.text = Lv
	pass


func _on_replay_pressed():
	SkillManager.emit_signal("DeactiveAllSkills")
	get_tree().change_scene_to_file("res://TSCN/Scene/default_scene.tscn")
	Character._Rebirth()
	pass # Replace with function body.


func _on_main_menu_pressed():
	SkillManager.emit_signal("DeactiveAllSkills")
	get_tree().change_scene_to_file("res://TSCN/Scene/StartScene.tscn")
	Character._Rebirth()
	pass # Replace with function body.
	
func _Set_Level():
	Level.text = "Level " + str(LevelManager.LevelNum)
	pass

func _Set_PlayerLV():
	PlayerLV.text = "LV "+ str(Character.LevelNum)
