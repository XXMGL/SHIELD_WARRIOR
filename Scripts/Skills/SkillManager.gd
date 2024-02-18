extends Node

var player
@export var skills : Array
#@onready var Skill1 = preload("res://TSCN/Player/Skills/shards_shoot_skills.tscn")
@onready var Skill1 = $ShardsShootSkills
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")
	skills.append(Skill1)
	#skills = []
	pass # Replace with function body.


func activate_skill(skill_index):
	skills[skill_index].activate()

func deactivate_skill(skill_index):
	skills[skill_index].deactivate()

	
func _process(delta):
	#print_debug(skills)
	activate_skill(0)
