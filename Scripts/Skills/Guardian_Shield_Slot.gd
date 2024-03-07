extends CanvasLayer

@onready var Slot = $Slot
var Empty_Slot_Texture = preload("res://ART Assets/ShieldSkill/7.png")
var Blue_Slot_Texture = preload("res://ART Assets/ShieldSkill/4.png")
var Yellow_Slot_Texture = preload("res://ART Assets/ShieldSkill/5.png")
var Red_Slot_Texture = preload("res://ART Assets/ShieldSkill/6.png")
var Slot_is_Trigger:bool = false
var Slot_is_Empty:bool = true
var is_Yellow_Shield:bool = false
var is_Red_Shield:bool = false

var Skill_Level = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Slot.texture = Empty_Slot_Texture
	#Character.connect("Gethit",Callable(self,"_Get_Hit"))
	#Character.connect("precise_Parry",Callable(self,"_Get_Guardian_Shield"))
	SkillManager.connect("B_Skill1_up",Callable(self,"_B_Skill1_up"))
	Character.connect("precise_Parry",Callable(self,"_Get_Guardian_Shield"))
	Character.connect("Gethit",Callable(self,"_Get_Hit"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _Get_Guardian_Shield():
	if Slot_is_Empty == true:
		Slot.texture = Blue_Slot_Texture
		Character.damage_Scale = 0
		if is_Yellow_Shield == true:
			Character.stamina_Recover = CharacterData.stamina_Recover * 2
		Slot_is_Empty = false
		#print_debug(Character.damage_Scale)
	pass
	
func _Get_Hit():
	if Slot_is_Empty == false:
		Slot.texture = Empty_Slot_Texture
		if is_Yellow_Shield == true:
			Character.stamina_Recover = CharacterData.stamina_Recover
		if is_Red_Shield == true:
			Character._Make_a_Shoot()
		#Character.damage_Scale = 1
		Slot_is_Empty = true
		#print_debug(Character.damage_Scale)
	pass
	
func _B_Skill1_up():
	Skill_Level += 1
	print_debug(Skill_Level)
	Slot_is_Trigger = true
	if Skill_Level == 1:
		pass
	if Skill_Level == 2:
		is_Yellow_Shield = true
		Slot.texture = Yellow_Slot_Texture
	if Skill_Level == 3:
		is_Red_Shield = true
		Slot.texture = Red_Slot_Texture
