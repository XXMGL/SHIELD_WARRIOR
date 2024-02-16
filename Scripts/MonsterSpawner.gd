extends Node

var SpwanLoactions = []
var Enemy1_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_1.tscn")
var Enemy2_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_2.tscn")
var Enemy4_Prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_4.tscn")
var Enemy100_prefab = preload("res://TSCN/Enemy/Enemies/enemy_type_100.tscn")
var WaveDuration = 10
@export var SpwanIndex: int
enum EnemyTypes{Enemy1, Enemy2 ,Enemy4, Enemy100}
@export var SpawnEnemy = EnemyTypes.Enemy1
@export var SpawnInterval: float
var spawn_timer: Timer
@export var SpawnAmout:int
@export var AllowedToSpawn = false
@export var Enemy_Route = "Route1"
var fullActivated = false


func _ready():
	spawn_timer = $Timer
	spawn_timer.wait_time  = SpawnInterval
	for child in $SpawnLocations.get_children():
		if child is Area2D:
			SpwanLoactions.append(child)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
				#NewEnemy.group_name = "Route"+str(randf_range(1, 2))
				#var routeName = "Route"+str(randi_range(1, 2))
				NewEnemy.group_name = Enemy_Route
				NewEnemy._change_route(NewEnemy.group_name)
				pass
			EnemyTypes.Enemy4:
				NewEnemy = Enemy4_Prefab.instantiate()
				#NewEnemy.group_name = "Route"+str(randf_range(1, 2))
				#var routeName = "Route"+str(randi_range(1, 2))
				NewEnemy.group_name = Enemy_Route
				pass
			EnemyTypes.Enemy100:
				NewEnemy = Enemy100_prefab.instantiate()
				pass
		NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		get_parent().add_child(NewEnemy)
		NewEnemy.add_to_group("Enemies")
		#NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		#print("NewEnemy.position: ", NewEnemy.position)
	if SpawnAmout <= 0:
		$Timer.stop()
		fullActivated = true
