extends HBoxContainer

@onready var heart_Space = preload("res://TSCN/UI/Heart_Space.tscn")

var Heart_Num = 3
var Max_HeartsNum = 3

var Hearts = []

@export var isLv3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Heart_Num = Character.HeartNum
	Max_HeartsNum = Character.HeartNum
	for i in range(Max_HeartsNum):
		var HS = heart_Space.instantiate()
		add_child(HS)
		#HS.isfilled = false
		pass
	Hearts = get_children()
	Character.connect("Gethit",Callable(self,"_GetHit"))
	Character.connect("precise_Parry",Callable(self,"_Recovery"))



	

func _GetHit():
	if Heart_Num >= 0:
		Character.health = 100
		Heart_Num -= 1
		#print(Hearts)
		Hearts[Heart_Num].isFilled = false
	if Heart_Num <= 0:
		Character.health = 0
		Character.Player_State = Character.state.STATE_DIE
	pass
	
func _Recovery():
	if Heart_Num<Max_HeartsNum and isLv3 == false:
		Heart_Num += 1
	#print(Hearts)
	Hearts[Heart_Num - 1].isFilled = true
	if isLv3 == true:
		for i in Max_HeartsNum-1:
			Hearts[i].isFilled = true
		pass
	

