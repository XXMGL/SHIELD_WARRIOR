extends Node

var SpwanLoactions = []

var WaveDuration = 10
@export var SpwanIndex: int
enum EnemyTypes
{Enemy1,
 Enemy2,
 Enemy3,
 Enemy4,
 Enemy5,
 Elite_Enemy1,
 Elite_Enemy2,
 Boss1,
 Boss2,}
@export var SpawnEnemyList = [EnemyTypes.Enemy2]
@export var EnemyLevel = 1
var SpawnEnemy: EnemyTypes
@export var SpawnInterval: float
var spawn_timer: Timer
@export var EXP_Pool = 100
var SpawnAmout:int
@export var AllowedToSpawn = false
@export var Enemy_Route = "Route1"
var fullActivated = false


func _ready():
	AllowedToSpawn = false
	SpawnEnemy = SpawnEnemyList[randi() % SpawnEnemyList.size()]
	
	SpawnAmout = 1
	if (SpawnEnemy != EnemyTypes.Boss1 && SpawnEnemy != EnemyTypes.Boss2):
		SpawnAmout = EXP_Pool / (get_exp_for_enemy_type(SpawnEnemy) * EnemyLevel)
	
	spawn_timer = $Timer
	spawn_timer.wait_time  = SpawnInterval
	for child in $SpawnLocations.get_children():
		if child is Area2D:
			SpwanLoactions.append(child)
	

func get_exp_for_enemy_type(enemy_type: int) -> int:
	# 遍历 enemy_data 中的所有键值对
	for enemy_group in EnemyInfor.enemy_data.values():
		# 遍历每个组别中的所有敌人类型
		for enemy_data in enemy_group.values():
			# 检查当前敌人类型是否与目标类型相匹配
			if enemy_data["EnemyType"] == enemy_type:
				# 如果匹配，则返回对应的 EXP 值
				return enemy_data["EXP"]
	# 如果未找到匹配的敌人类型，返回默认值
	return 0


func _on_timer_timeout():
	if SpawnAmout >= 1 && AllowedToSpawn == true:
		SpawnAmout -= 1
		var NewEnemy = null
		match SpawnEnemy:
			EnemyTypes.Enemy1:
				var prefab  = load(EnemyInfor.enemy_data["Normal"]["Enemy 1"]["Path"])
				NewEnemy = prefab.instantiate()
				pass
				
			EnemyTypes.Enemy2:
				var prefab  = load(EnemyInfor.enemy_data["Normal"]["Enemy 2"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				# NewEnemy._change_route(NewEnemy.group_name)
				pass
				
			EnemyTypes.Enemy3:
				var prefab  = load(EnemyInfor.enemy_data["Normal"]["Enemy 3"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
				
			EnemyTypes.Enemy4:
				var prefab  = load(EnemyInfor.enemy_data["Normal"]["Enemy 4"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
			EnemyTypes.Enemy5:
				var prefab  = load(EnemyInfor.enemy_data["Normal"]["Enemy 5"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
			EnemyTypes.Elite_Enemy1:
				var prefab  = load(EnemyInfor.enemy_data["Elite"]["Enemy 1"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
			EnemyTypes.Elite_Enemy2:
				var prefab  = load(EnemyInfor.enemy_data["Elite"]["Enemy 2"]["Path"])
				NewEnemy = prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
			
			EnemyTypes.Boss1:
				var prefab = load(EnemyInfor.enemy_data["Boss"]["Boss1"]["Path"])
				NewEnemy = prefab.instantiate()
				pass
			
			EnemyTypes.Boss2:
				var prefab = load(EnemyInfor.enemy_data["Boss"]["Boss2"]["Path"])
				NewEnemy = prefab.instantiate()
				pass
				
		NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		get_parent().add_child(NewEnemy)
		NewEnemy.add_to_group("Enemies")
		#NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		#print("NewEnemy.position: ", NewEnemy.position)
	if SpawnAmout <= 0:
		$Timer.stop()
		fullActivated = true
