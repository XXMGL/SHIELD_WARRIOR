extends CanvasLayer

var Tutorial_Images = []
var images_index = 1
var maximum_index = 1

@onready var CloseButton = $"Close button"
@onready var NextButton = $NextButton
@onready var PreviousButton = $PreviousButton

func _ready():
	CloseButton.disabled = true
	NextButton.disabled = false
	PreviousButton.disabled = true
	_Load_Totorial_img()

func _on_close_button_button_down():
	Tutorial_Images = []
	images_index = 1
	var lv_up_window = get_tree().get_first_node_in_group("Level_up")
	if lv_up_window == null:
		get_tree().paused = false
	queue_free()
	
func _Load_Totorial_img():
	#var img = load("res://ART Assets/Tutorials/"+key+".png")
	#var Tutorial_Image = $TutorialImage/img
	#Tutorial_Image.texture = img
	var img = load(str(Tutorial_Images[images_index - 1]))
	var Tutorial_Image = $TutorialImage/img
	Tutorial_Image.texture = img
	if images_index>=maximum_index-1:
		NextButton.disabled = true
	else:
		NextButton.disabled = false	
	if images_index > 1:
		PreviousButton.disabled = false
	else:
		PreviousButton.disabled = true
	if images_index>=maximum_index-1:
		CloseButton.disabled = false
	else:
		CloseButton.disabled = true


func _on_next_button_pressed():
	if images_index<=maximum_index-1:
		images_index += 1
		_Load_Totorial_img()
		if images_index>=maximum_index-1:
			NextButton.disabled = true
		if images_index > 1:
			PreviousButton.disabled = false
		if images_index>=maximum_index-1:
			CloseButton.disabled = false
	pass # Replace with function body.


func _on_previous_button_pressed():
	if images_index>1:
		images_index -= 1
		_Load_Totorial_img()
		if images_index<=maximum_index-1:
			NextButton.disabled = false
		if images_index <= 1:
			PreviousButton.disabled = true
			
	pass # Replace with function body.
