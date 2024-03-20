extends Area2D
@export var Damage = 0.5
@onready var TriggerTimer = $Timer
var Trigger_Duration = 1.2
var Trigger_Duration_Decline_Times = 0
var Trigger_Duration_Default = 1.2
var Target
var is_Lv4 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_Lv4 = false
	Trigger_Duration_Decline_Times = 0
	Trigger_Duration_Default = Trigger_Duration
	TriggerTimer.wait_time = Trigger_Duration
	CharacterData.connect("G_Skill5_Change_Target",Callable(self,"_Change_Target"))
	SkillManager.connect("DeactiveAllSkills",Callable(self,"deactivate"))
	pass # Replace with function body.

func _process(delta):
	if Target!= null:
		global_position = Target.global_position
	if CharacterData.G_Skill5_Active_Lv4 == true and is_Lv4 == false:
		_Signal_Connection()
		is_Lv4 = true


func _Search_Enemies():
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Enemies") and body.has_method("_EnemyDetection"):
			body.Health -= Damage
			#print_debug("Body: ", body," Health: ", body.Health)
			
func deactivate():
	queue_free()
	
	
	


func _on_timer_timeout():
	_Search_Enemies()
	pass # Replace with function body.


func _on_body_entered(body):
	if body.has_method("_EnemyDetection"):
		body.Poison_Trigger_Duration *= 0.7
		#print_debug(body.Poison_Trigger_Duration)
	pass # Replace with function body.


func _on_body_exited(body):
	if body.has_method("_EnemyDetection"):
		body.Poison_Trigger_Duration = body.Poison_Trigger_Duration_Default
		#print_debug(body.Poison_Trigger_Duration)
	pass # Replace with function body.
	
func Pick_Up_Item():
	if Trigger_Duration_Decline_Times <= 10:
		Trigger_Duration_Decline_Times += 1
		Trigger_Duration -= Trigger_Duration_Default*0.05
		#print_debug(Trigger_Duration)
		
func _Signal_Connection():
	CharacterData.connect("Pick_Up_Item",Callable(self,"Pick_Up_Item"))

func _Change_Target():
	var Mouse_Pos = get_tree().get_first_node_in_group("Mouse_Pos")
	Target = Mouse_Pos
