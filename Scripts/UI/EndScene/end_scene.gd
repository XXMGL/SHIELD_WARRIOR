extends CanvasLayer

@onready var Skills_Container = $Panel2/Skills_Container
@onready var Level = $Level
@onready var PlayerLV = $PlayerLV
@onready var EnemyAnimation = $BG1/AnimatedSprite2D2
@onready var EnemyAnimation2 = $BG1/AnimatedSprite2D3
@onready var EnemyAnimation3 = $BG1/AnimatedSprite2D4
@onready var EnemyAnimation4 = $BG1/AnimatedSprite2D5
@onready var EnemyAnimation5 = $BG1/AnimatedSprite2D6
@onready var Killer = $Killer2
@onready var Killer_Text = $Killer
var Skills_Icon = preload("res://TSCN/UI/End_Scene_Skill_Display.tscn")
var Skills_Size = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.emit_signal("End_Game")
	_HidePlayer()
	_Get_Skills_Size()
	_Set_Skills_Icons()
	_Set_PlayerLV()
	_Set_Level()
	_Set_Timer()
	EnemyAnimation.play("idle")
	EnemyAnimation2.play("idle")
	EnemyAnimation3.play("idle")
	EnemyAnimation4.play("idle")
	EnemyAnimation5.play("idle")
	if Character.isDead == true:
		Killer_Text.text = "The killer is"
		Killer.play(str(Character.Enemy_index))
	elif Character.isDead == false:
		Killer_Text.text = "congratulation!!"
		Killer.play("0")
	pass # Replace with function body.



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
		# print_debug("skillName: ", skillName)
		# print_debug("Activate_Skills: ", skill_i)


func _on_replay_pressed():
	LevelManager.emit_signal("Start_Game")
	SkillManager.emit_signal("DeactiveAllSkills")
	#get_tree().change_scene_to_file("res://TSCN/Scene/default_scene.tscn")
	get_tree().change_scene_to_packed(load("res://TSCN/Scene/default_scene.tscn"))
	Character._Rebirth()



func _on_main_menu_pressed():
	SkillManager.emit_signal("DeactiveAllSkills")
	#get_tree().change_scene_to_file("res://TSCN/Scene/StartScene.tscn")
	get_tree().change_scene_to_packed(load("res://TSCN/Scene/StartScene.tscn"))
	Character._Rebirth()

	
func _Set_Level():
	Level.text = "Level " + str(LevelManager.LevelNum)


func _Set_PlayerLV():
	PlayerLV.text = "LV "+ str(Character.LevelNum)
	
func _Set_Timer():
	var Display_Time = $Timer
	Display_Time.text = str(LevelManager.Game_Time_h_str)+":"+str(LevelManager.Game_Time_m_str)+":"+ str(LevelManager.Game_Time_s_str)
