extends Button

var Sk_Layout1 = preload("res://ART Assets/Level_1_templete.png")
var Sk_Layout2 = preload("res://ART Assets/Level_2_templete.png")

enum SK{skill1,skill2}
@export var Skill = SK.skill1

# Called when the node enters the scene tree for the first time.
func _ready():
	var Layout = get_child(0)
	match Skill:
		SK.skill1:
			Layout.texture = Sk_Layout1
			pass
		SK.skill2:
			Layout.texture = Sk_Layout2
			pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
