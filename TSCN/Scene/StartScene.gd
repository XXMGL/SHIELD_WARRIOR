extends CanvasLayer

@onready var CharacterAnimation = $AnimatedSprite2D
@onready var EnemyAnimation = $AnimatedSprite2D2

func _ready():
	_HidePlayer()
	CharacterAnimation.play("idle")
	EnemyAnimation.play("idle")
	pass


func _HidePlayer():
	
	Character.process_mode = Node.PROCESS_MODE_DISABLED
	Character.visible = false
	Character._hide_UI()
	
