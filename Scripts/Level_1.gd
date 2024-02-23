extends Node2D


@onready var Level_Timer = $Timer
@onready var LevelProgressBar = $UI/LevelProgress
@onready var LevelIndicator = $UI/LevelProgress/Sprite2D


var powerup = preload("res://TSCN/Powerup/powerup_basic.tscn")

var LevelLength: float
var LevelLength_Max :float
var progress:float
var WaveLength:float
var WaveTimer:float
@export var Level_Path:String
@export var Waves: Array
var WaveNum = 0
var Spwaners = []
var SpawnersForThisWave = []
var WaveEnd = false

#Wave间结算
var PL_bw
var PL_aw
var PL_N

#关卡间结算


func _ready():
	Activate_Character()
	PL_bw = Character.LevelNum
	PL_aw = Character.LevelNum
	WaveNum = 0
	progress = 0
	Level_Timer.start()
	_GetLevelLength()
	_GetWaveLength()
	_ActivateSpawners()
	LevelProgressBar.connect("value_changed",Callable(self,"_on_progress_value_changed"))

	



func _process(delta):
	LevelProgressBar.value = progress*100/LevelLength_Max
	_WaveCheck()
	pass



func _on_timer_timeout():
	progress += 1
	WaveTimer -= 1
	#print("关卡进行中，剩余： ", LevelLength)
	if WaveTimer <= 0:
		LevelLength -= WaveLength
		WaveNum+=1
		_GetWaveLength()
		#_DeactivateSpawners()
		_ActivateSpawners()
		WaveEnd = false
	if WaveNum >= Waves.size():
		progress = LevelLength_Max
		var FinalWaves = get_tree().get_nodes_in_group("FinalWave")
		for FinalWave in FinalWaves:
			FinalWave.AllowedToSpawn = true
		#$Timer.stop()


func _GetWaveLength():
	if WaveNum <= Waves.size()-1:	
		WaveTimer = Waves[WaveNum]
		WaveLength = Waves[WaveNum]
	pass

func _GetLevelLength():
	for Wave in Waves:
		LevelLength += Wave
		LevelLength_Max = LevelLength
		
func _ActivateSpawners():
	if WaveNum >= Waves.size(): return
	var WaveGroupName = "Wave" + str(WaveNum+1)
	SpawnersForThisWave = get_tree().get_nodes_in_group(WaveGroupName)
	for spawner in SpawnersForThisWave:
		spawner.AllowedToSpawn = true
	pass
	
func _DeactivateSpawners():
	for spawner in Spwaners:
		spawner.AllowedToSpawn = false
		pass

func _WaveCheck():
	var EnemiesInGround = get_tree().get_nodes_in_group("Enemies")
	var spawner_HasEnemies = SpawnersForThisWave.size()
	for spawner in SpawnersForThisWave:
		if spawner.fullActivated == true:
			spawner_HasEnemies -= 1
	if spawner_HasEnemies == 0 and EnemiesInGround.size() == 1 and WaveEnd == false: # powerup释放点
		var Powerup = powerup.instantiate()
		get_parent().add_child(Powerup)
		progress += WaveTimer -3
		WaveTimer = 3
		WaveEnd = true
		
func _on_progress_value_changed(value):
	var max_width = 500
	var Indicator_progress = value / LevelProgressBar.max_value
	var target_x = max_width * Indicator_progress
	LevelIndicator.position.x = target_x
	pass
	
func load_next_level():
	
	get_tree().change_scene_to_file(Level_Path)
	
func Level_Up_WaveCheck():
	PL_aw = Character.LevelNum
	var Level_Up_Window_prefab = preload("res://TSCN/UI/level_up.tscn")
	var Level_Up_Window = Level_Up_Window_prefab.instantiate()
	add_child(Level_Up_Window)
	# 禁用游戏中的各种活动
	get_tree().paused = true	
	pass
	
func Activate_Character():
	if Character.process_mode != Node.PROCESS_MODE_INHERIT:
		Character.process_mode = Node.PROCESS_MODE_INHERIT
		Character.visible = true
	Character._Show_UI()
		



