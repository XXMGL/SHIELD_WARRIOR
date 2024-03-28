extends CanvasLayer

signal enter_Level1
signal power_up_showing_up
signal leving_up_interface

var enter_Level1_Num = 0
var power_up_showing_up_Num = 0 
var leving_up_interface_Num = 0

var tutorial_interface = preload("res://TSCN/UI/tutorial_interface.tscn")

func _ready():
	connect("enter_Level1",Callable(self,"_add_on_enter_Level1_Num"))
	connect("power_up_showing_up",Callable(self,"_add_on_power_up_showing_up_Num"))
	connect("leving_up_interface",Callable(self,"_add_on_leving_up_interface_Num"))
	pass 



func _process(delta):
	pass

func _add_on_enter_Level1_Num():
	enter_Level1_Num+=1
	if enter_Level1_Num == 1:
		var T_I = tutorial_interface.instantiate()
		for i in range(9):
			var j = i + 1
			var image_route = "res://ART Assets/Tutorials/Tutorial"+ str(j)+".png"
			T_I.Tutorial_Images.append(image_route) 
			T_I.maximum_index = i + 1
		#T_I._Load_Totorial_img()
		#get_parent().add_child(T_I)
		get_parent().add_child.call_deferred(T_I)
		get_tree().paused = true
func _add_on_leving_up_interface_Num():
	leving_up_interface_Num+=1
	if leving_up_interface_Num == 1:
		var T_I = tutorial_interface.instantiate()
		for i in range(5):
			var j = i + 10
			var image_route = "res://ART Assets/Tutorials/Tutorial"+ str(j)+".png"
			T_I.Tutorial_Images.append(image_route) 
			T_I.maximum_index = i + 1
		#T_I._Load_Totorial_img()
		get_parent().add_child(T_I)
		get_tree().paused = true
func _add_on_power_up_showing_up_Num():
	power_up_showing_up_Num+=1
	if power_up_showing_up_Num == 1:
		var T_I = tutorial_interface.instantiate()
		var image_route = "res://ART Assets/Tutorials/Tutorial"+ str(15)+".png"
		T_I.Tutorial_Images.append(image_route) 
		#T_I._Load_Totorial_img()
		T_I.maximum_index = 1
		get_parent().add_child(T_I)
		get_tree().paused = true
