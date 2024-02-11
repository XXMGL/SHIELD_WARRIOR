extends Node2D

@export var LevelLength: float
@onready var Level_Timer = $Timer
@export var Waves: Array

var Enemy1_prefab = preload("res://Scripts/Enemy_Type1.gd")
var Enemy2_prefab = preload("res://Scripts/Enemy_Type2.gd")

func _ready():
	Level_Timer.start()

	


func _process(delta):
	pass




func _on_timer_timeout():
	LevelLength -= 1
	#print("关卡进行中，剩余： ", LevelLength)
	if LevelLength <= 0:
		Level_Timer.stop()
		# 进入关底Boss

