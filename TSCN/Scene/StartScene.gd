extends CanvasLayer

@onready var EnemyAnimation = $BG1/AnimatedSprite2D2
@onready var EnemyAnimation2 = $BG1/AnimatedSprite2D3
@onready var EnemyAnimation3 = $BG1/AnimatedSprite2D4
@onready var EnemyAnimation4 = $BG1/AnimatedSprite2D5
@onready var EnemyAnimation5 = $BG1/AnimatedSprite2D6

func _ready():
	SkillManager.emit_signal("DeactiveAllSkills")
	_HidePlayer()
	EnemyAnimation.play("idle")
	EnemyAnimation2.play("idle")
	EnemyAnimation3.play("idle")
	EnemyAnimation4.play("idle")
	EnemyAnimation5.play("idle")
	pass


func _HidePlayer():
	Character.process_mode = Node.PROCESS_MODE_DISABLED
	Character.visible = false
	Character._hide_UI()
	
