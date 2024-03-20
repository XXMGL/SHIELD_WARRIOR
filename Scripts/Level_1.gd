extends Node2D


@onready var Level_Timer = $Timer
@onready var LevelProgressBar = $UI/LevelProgress
@onready var LevelIndicator = $UI/LevelProgress/Sprite2D


var powerup = preload("res://TSCN/Powerup/powerup_basic.tscn")

@export var Level_index = 1
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
var lastWaveStarted = false
var Reward_is_Shown = false

#Wave间结算
var PL_bw
var PL_aw
var PL_N

#关卡间结算

#升级时技能稀有度权重
var skills_L_weight = 1
var skills_B_weight = 5
var skills_G_weight = 5


func _ready():
	Tutorial.emit_signal("enter_Level1")
	
	Character.Allow_To_Control = true
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
	
	Character.health = 100
	Character.isDead = false
	Character._Rebirth()
	Character.process_mode = Node.PROCESS_MODE_INHERIT
	
	LevelManager.connect("Final_Enemy_Die",Callable(self,"Level_Acomplish"))
	LevelManager.LevelNum = Level_index



func _process(_delta):
	LevelProgressBar.value = progress * 100/LevelLength_Max
	Level_Up_WaveCheck()
	_WaveCheck()
	pass



func _on_timer_timeout():
	progress += 1
	WaveTimer -= 1
	#print("关卡进行中，剩余： ", LevelLength)
	if WaveTimer <= 0 and WaveNum < Waves.size():
		PL_aw = Character.LevelNum
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
		_Last_Wave_Check()

func _Last_Wave_Check():
	var EnemiesInGround = get_tree().get_nodes_in_group("Enemies")
	if EnemiesInGround.size() > 1 and lastWaveStarted == false:
		lastWaveStarted = true
	if EnemiesInGround.size() <= 1 and lastWaveStarted == true:
		LevelManager.emit_signal("Final_Enemy_Die")
	pass


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
	LevelManager.emit_signal("Move_In_Next_Level")
	#get_tree().change_scene_to_file(Level_Path)
	get_tree().call_deferred("change_scene_to_file",Level_Path)
	
	
func Level_Up_WaveCheck():
	PL_aw = Character.LevelNum
	if PL_aw > PL_bw:
		Tutorial.emit_signal("leving_up_interface")
		PL_bw += 1
		LevelManager.Level_up_Interface(skills_L_weight,skills_B_weight,skills_G_weight)
	pass
	
func Activate_Character():
	if Character.process_mode != Node.PROCESS_MODE_INHERIT:
		Character.process_mode = Node.PROCESS_MODE_INHERIT
		Character.visible = true
	Character._Show_UI()
	
func Level_Acomplish():
	if Reward_is_Shown == false:
		LevelManager.Level_up_Interface(10,1,0)	
		Character.Allow_To_Control = false
		Reward_is_Shown = true
	
func _on_jump_to_next_level_body_entered(body):
	if body.has_method("_CharacterDetection"):
		if body.Allow_To_Control == false:
			_Reposition_Character(body)
			load_next_level()
			Character.Allow_To_Control = true
		pass
	pass # Replace with function body.
	
func _Reposition_Character(Char):
	var Default_Position = $Player_Defalult_position
	Char.global_position = Default_Position.global_position
	pass

