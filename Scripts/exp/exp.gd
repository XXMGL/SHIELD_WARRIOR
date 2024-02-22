extends CharacterBody2D

@export var exp_Num = 1
var Speed = 300
var exp_Timer = 0.0
var MoveDir
var ToExpBar = false


func _ready():
	var scale_factor =calculate_scale(exp_Num)
	scale = Vector2(scale_factor, scale_factor)
	MoveDir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	ToExpBar = false

func _physics_process(delta):
	if Speed >= 0 and ToExpBar == false:
		Speed -= 7
	else:
		ToExpBar = true
		FindExpBar()
		Speed += 10
		pass
	
	velocity = MoveDir*Speed
	move_and_slide()
	pass

func calculate_scale(Num: int) -> float:
	return 3 + (Num - 1) / 3
	
func FindExpBar():
	var ExpBar = get_tree().get_first_node_in_group("ExpBar")
	if ExpBar != null:
		MoveDir = (ExpBar.global_position - global_position).normalized()


func _on_area_2d_area_entered(area):
	if area.has_method("Exp_Bar_Detection"):
		Character.Exp+=exp_Num
		#print_debug(Character.Exp)
		queue_free()
	pass # Replace with function body.
