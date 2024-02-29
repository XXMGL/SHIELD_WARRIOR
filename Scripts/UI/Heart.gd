extends Panel

@export var isFilled = true

var Heart_png = preload("res://ART Assets/heart.png")
var Empty_Heart = preload("res://ART Assets/Monster.png")
var Heart_Sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	Heart_Sprite = get_child(0)
	#print_debug(Heart_Sprite)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isFilled == true:
		Heart_Sprite.texture = Heart_png
		pass
	elif isFilled == false:
		Heart_Sprite.texture = Empty_Heart
		pass
	pass
