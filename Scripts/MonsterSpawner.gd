extends Node

var SpwanLoactions = []
var Enemy1_prefab = preload("res://TSCN/enemy_type_1.tscn")
var Enemy2_prefab = preload("res://TSCN/enemy_type_2.tscn")
var WaveDuration = 10
@export var SpwanIndex: int
enum EnemyTypes{Enemy1, Enemy2}
@export var SpawnEnemy = EnemyTypes.Enemy1
@export var SpawnInterval: float
var spawn_timer: Timer
@export var SpawnAmout:int

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
	if SpawnAmout >= 1:
		SpawnAmout -= 1
		var NewEnemy = null
		match SpawnEnemy:
			EnemyTypes.Enemy1:
				NewEnemy = Enemy1_prefab.instantiate()
				pass
			EnemyTypes.Enemy2:
				NewEnemy = Enemy2_prefab.instantiate()
				pass
		NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		get_parent().add_child(NewEnemy)
		#NewEnemy.position = SpwanLoactions[SpwanIndex].global_position
		print("NewEnemy.position: ", NewEnemy.position)
