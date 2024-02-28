extends CharacterBody2D

var tail = preload("res://TSCN/Enemy/Enemies/enemy_type_101_Tail.tscn")
@onready var tailGenerateTimer = $Tail_Generate_Timer
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
	tailGenerateTimer.wait_time = tailGenerateDuration
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
			
	move()
	move_and_slide()
	
func move():
	velocity = move_direction.direction * move_speed
			
func add_tails():
	if (tails.size() < 6):
		var new_tail = tail.instantiate()
		new_tail.move_speed = move_speed
		new_tail.group_name = group_name
		get_parent().add_child(new_tail)
		tails.append(new_tail)



func _on_tail_generate_timer_timeout():
	add_tails()
	
