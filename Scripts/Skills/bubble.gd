extends Area2D

var Damage = 0.1
var move_speed = 0.1
var health = 1
var bullet_Num = 5
var bullet_Prefab = preload("res://TSCN/Bullet/bullet_R_1.tscn")

func _ready():
	#print_debug(CharacterData.B_Skill3_Branch_index)
	pass

func _process(delta):
	if CharacterData.B_Skill3_Active_Lv3 == true and CharacterData.B_Skill3_Branch_index == 1:
		_Search_Enemies(delta)

func _on_enemy_detector_body_entered(body):
	if body.has_method("_EnemyDetection"):
		body.Health -= Damage
		if CharacterData.B_Skill3_Active_Lv4 == true and CharacterData.B_Skill3_Branch_index == 1:
			body.Freeze = true
		Burst()
		queue_free()
	if body.has_method("OriginFromEnemy") and CharacterData.B_Skill3_Branch_index == 2:
		if body.OriginFromEnemy() == true:
			body.queue_free()
			health -= 1
			if health <=0:
				Burst()
				queue_free()
		#queue_free()
		pass
	pass # Replace with function body.
	
	
func _Search_Enemies(delta):
	var overlapping_bodies = get_overlapping_bodies()
	var Target
	var Short_Distance = 999
	for body in overlapping_bodies:
		if body.is_in_group("Enemies") and body.has_method("_EnemyDetection"):
			var Dis = global_position.distance_to(body.global_position)
			if Dis < Short_Distance:
				Target = body
	if Target != null:
		var MoveDirection = (Target.global_position - global_position).normalized()
		global_position += MoveDirection*move_speed
		
func _Bubble_Detection():
	if CharacterData.B_Skill3_Branch_index == 1:
		return false
	elif CharacterData.B_Skill3_Branch_index == 2:
		return true
		
func Burst():
	if CharacterData.B_Skill3_Active_Lv4 == true and CharacterData.B_Skill3_Branch_index == 2:
		for i in bullet_Num:
			var bullet = bullet_Prefab.instantiate()
			get_parent().call_deferred("add_child",bullet)
			var random_angle = randf_range(0, 360)
			bullet.MoveDirection = Vector2.RIGHT.rotated(deg_to_rad(random_angle))
			bullet.global_position = global_position
			#print("bullet : ", bullet , " Direction : ",bullet.MoveDirection)
			
