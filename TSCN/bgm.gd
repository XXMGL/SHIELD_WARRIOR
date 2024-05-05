extends Node
@onready var AudioPlayer = $AudioStreamPlayer
@onready var AudioPlayer2 = $AudioStreamPlayer2
var ManiMenu_Bgm = preload("res://ART Assets/BGM/MainMenu.wav")
var InLevel_Bgm = preload("res://ART Assets/BGM/BGM.wav")
var Button_Click = preload("res://ART Assets/BGM/button_cool.ogg")


signal ManiMenu
signal InLevel
signal ButtonClick

func _ready():
	connect("ManiMenu",Callable(self,"_Play_MainMenu_Bgm"))
	connect("InLevel",Callable(self,"_Play_InLevel_Bgm"))
	connect("ButtonClick",Callable(self,"_ButtonClick"))
	
func _Play_MainMenu_Bgm():
	AudioPlayer.stop()
	AudioPlayer.stream = ManiMenu_Bgm
	AudioPlayer.play()
	
func _Play_InLevel_Bgm():
	AudioPlayer.stop()
	AudioPlayer.stream = InLevel_Bgm
	AudioPlayer.play()
	
func _ButtonClick():
	AudioPlayer2.stream = Button_Click
	AudioPlayer2.play()
