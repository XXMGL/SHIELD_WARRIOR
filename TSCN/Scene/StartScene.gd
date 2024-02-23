extends CanvasLayer


func _ready():
	_HidePlayer()
	pass


func _HidePlayer():
	
	Character.process_mode = Node.PROCESS_MODE_DISABLED
	Character.visible = false
	Character._hide_UI()
	
