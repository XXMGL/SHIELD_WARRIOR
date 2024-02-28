extends CharacterBody2D

var tail = preload("res://TSCN/Enemy/Enemies/enemy_type_101_Tail.tscn")
@onready var tailGenerateTimer = $Tail_Generate_Timer
var tailGenerateWaitTime = 0
var tailGenerateDuration = 0.2

@export var move_direction = Node2D
@export var move_speed = 100
var tails = []

@export var group_name : String
@export var ShootDuration = 2.0

@export var MaxHealth = 1000

var prev_dir = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	tailGenerateWaitTime += delta
	if (tailGenerateWaitTime > tailGenerateDuration):
		tailGenerateWaitTime = 0
		tailGenerateTimer.wait_time = tailGenerateDuration
		tailGenerateTimer.start()
			
	move()
	move_and_slide()
	
func move():
	velocity = move_direction.direction * move_speed
	
	var dir_change = false
	if (prev_dir != move_direction.direction):
		prev_dir = move_direction.direction
		dir_change = true
	if (dir_change == true):
		for i in tails:
			i.add_move_dir_to_tail(position, move_direction.direction)
			
func add_tails():
	if (tails.size() < 6):
		var new_tail = tail.instantiate()
		new_tail.move_speed = move_speed
		get_parent().add_child(new_tail)
		tails.append(new_tail)



func _on_tail_generate_timer_timeout():
	add_tails()
	
