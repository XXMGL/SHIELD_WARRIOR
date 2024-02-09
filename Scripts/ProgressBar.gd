extends ProgressBar

@onready var timer = $Timer
@onready var progressBar2 = $ProgressBar2

var value_1 = 0: set = _set_value

func _set_value(new_value):
	print(new_value)
	var prev_value = value_1
	value_1 = min(max_value,new_value)
	value = value_1
	
	if value_1 <= 0:
		pass
	if value_1 < prev_value:
		timer.start()
	else:
		progressBar2.value = value_1


func init_value(Input_value):
	value_1 = Input_value
	max_value = value_1
	value = value_1
	progressBar2.max_value = value_1
	progressBar2.max_value = value_1



func _on_timer_timeout():
	progressBar2.value = value_1
