extends Node

var SpwanLoactions = []

# Level 1 Normal Enemy
var Enemy1_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_1.tscn")
var Enemy2_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_2.tscn")
var Enemy3_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_3.tscn")
var Enemy4_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_4.tscn")
var Enemy6_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_6.tscn")

# Level 1 Elite Enemy
var Enemy5_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_5.tscn")
var Enemy7_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_7.tscn")

# Level 2 Normal Enemy
var Normal_Enemy_1_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Normal/normal_enemy_1_level_2.tscn")
var Normal_Enemy_2_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Normal/normal_enemy_2_level_2.tscn")
var Normal_Enemy_3_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Normal/normal_enemy_3_level_2.tscn")
var Normal_Enemy_4_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Normal/normal_enemy_4_level_2.tscn")
var Normal_Enemy_5_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Normal/normal_enemy_5_level_2.tscn")

# Level 2 Elite Enemy
var Elite_Enemy_1_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Elite/elite_enemy_1_level_2.tscn")
var Elite_Enemy_2_Level2_prefab = preload("res://TSCN/Enemy/Enemies/Level2 Enemys/Elite/elite_enemy_2_level_2.tscn")

# Boss
var Enemy100_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_100.tscn")
var Enemy101_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_101.tscn")


var WaveDuration = 10
@export var SpwanIndex: int
enum EnemyTypes
{Enemy1,
 Enemy2,
 Enemy3,
 Enemy4,
 Enemy5,
 Enemy6,
 Enemy7,
 Normal_Enemy_1_Level2,
 Normal_Enemy_2_Level2,
 Normal_Enemy_3_Level2,
 Normal_Enemy_4_Level2,
 Normal_Enemy_5_Level2, 
 Elite_Enemy_1_Level2,
 Elite_Enemy_2_Level2,
 Enemy100,
 Enemy101,}
@export var SpawnEnemy = EnemyTypes.Enemy1
@export var SpawnInterval: float
var spawn_timer: Timer
@export var SpawnAmout:int
@export var AllowedToSpawn = false
@export var Enemy_Route = "Route1"
var fullActivated = false


func _ready():
	AllowedToSpawn = false
	spawn_timer = $Timer
	spawn_timer.wait_time  = SpawnInterval
	for child in $SpawnLocations.get_children():
		if child is Area2D:
			SpwanLoactions.append(child)
	




func _on_timer_timeout():
	if SpawnAmout >= 1 && AllowedToSpawn == true:
		SpawnAmout -= 1
		var NewEnemy = null
		match SpawnEnemy:
			EnemyTypes.Enemy1:
				NewEnemy = Enemy1_prefab.instantiate()
				pass
				
			EnemyTypes.Enemy2:
				NewEnemy = Enemy2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				# NewEnemy._change_route(NewEnemy.group_name)
				pass
				
			EnemyTypes.Enemy3:
				NewEnemy = Enemy3_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
				
			EnemyTypes.Enemy4:
				NewEnemy = Enemy4_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Enemy5:
				NewEnemy = Enemy5_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
			EnemyTypes.Enemy6:
				NewEnemy = Enemy6_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
			EnemyTypes.Enemy7:
				NewEnemy = Enemy7_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass 
				
			# Level 2 Enemy
			EnemyTypes.Normal_Enemy_1_Level2:
				NewEnemy = Normal_Enemy_1_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Normal_Enemy_2_Level2:
				NewEnemy = Normal_Enemy_2_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Normal_Enemy_3_Level2:
				NewEnemy = Normal_Enemy_3_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Normal_Enemy_4_Level2:
				NewEnemy = Normal_Enemy_4_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Normal_Enemy_5_Level2:
				NewEnemy = Normal_Enemy_5_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
			
			EnemyTypes.Elite_Enemy_1_Level2:
				NewEnemy = Elite_Enemy_1_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
				
			EnemyTypes.Elite_Enemy_2_Level2:
				NewEnemy = Elite_Enemy_2_Level2_prefab.instantiate()
				NewEnemy.group_name = Enemy_Route
				pass
			
			EnemyTypes.Enemy100:
				NewEnemy = Enemy100_prefab.instantiate()
				pass
			
			EnemyTypes.Enemy101:
				NewEnemy = Enemy101_prefab.instantiate()
				pass
				
		NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		get_parent().add_child(NewEnemy)
		NewEnemy.add_to_group("Enemies")
		#NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		#print("NewEnemy.position: ", NewEnemy.position)
	if SpawnAmout <= 0:
		$Timer.stop()
		fullActivated = true
