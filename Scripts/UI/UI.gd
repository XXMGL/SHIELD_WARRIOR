extends CanvasLayer
# 游戏暂停标志
var is_paused = false

func _input(event):
	if event.is_action_pressed("Pause"):
		if get_tree().paused:
			get_tree().paused = false
		toggle_pause()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 切换暂停状态
func toggle_pause():
	if is_paused:
		resume_game()
	else:
		pause_game()
# 暂停游戏
func pause_game():
	is_paused = true
	# 加载暂停菜单场景
	var pause_menu_scene = preload("res://TSCN/UI/Pause_Menu.tscn")
	# 实例化暂停菜单场景并添加到界面中
	var pause_menu_instance = pause_menu_scene.instantiate()
	add_child(pause_menu_instance)
	
	 # 禁用游戏中的各种活动
	get_tree().paused = true


# 恢复游戏
func resume_game():
	is_paused = false
	# 删除暂停菜单场景
	var pause_menu = get_node("Pause_Menu")
	if pause_menu:
		pause_menu.queue_free()
	# 恢复游戏中的各种活动
	get_tree().paused = false
