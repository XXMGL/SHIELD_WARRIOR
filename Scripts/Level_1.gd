extends Node2D

var LevelLength: float
var WaveLength:float
var WaveTimer:float
@onready var Level_Timer = $Timer
@export var Waves: Array
var WaveNum = 0
var Spwaners = []
var SpawnersForThisWave = []
var WaveEnd = false

func _ready():
	WaveNum = 0
	Level_Timer.start()
	_GetLevelLength()
	_GetWaveLength()
	_ActivateSpawners()

	


func _process(delta):
	_WaveCheck()
	pass




func _on_timer_timeout():
	WaveTimer -= 1
	#print("关卡进行中，剩余： ", LevelLength)
	if WaveTimer <= 0:
		LevelLength -= WaveLength
		WaveNum+=1
		_GetWaveLength()
		#_DeactivateSpawners()
		_ActivateSpawners()
		WaveEnd == false
	if LevelLength <= 0:
		$Timer.stop()


func _GetWaveLength():
	if WaveNum <= Waves.size()-1:	
		WaveTimer = Waves[WaveNum]
		WaveLength = Waves[WaveNum]
	pass

func _GetLevelLength():
	for Wave in Waves:
		LevelLength += Wave
		
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
	if spawner_HasEnemies == 0 and EnemiesInGround.size() == 1 and WaveEnd == false:
		WaveTimer = 3
		WaveEnd = true
