extends Node2D

@onready var scene_manager :CoreSystem.SceneManager =  CoreSystem.scene_manager
@onready var game_scene = "res://Scenes/game/主游戏界面.tscn"
@onready var button_ri = $"创建人物界面/日"
@onready var button_yue = $"创建人物界面/月"

	
	#$"创建人物界面".visible = false
	#
	#print(Dialogic.VAR.get_variable("player_name")==null)
	# var a : Array =  


func _on_button_ri():
	
	print("以逢炎为角色进行战斗。")
	scene_manager.change_scene_async(
	game_scene,    # 场景路径
	{"level": 1},               # 场景数据
	true,                       # 保存到栈
	scene_manager.TransitionEffect.FADE,  # 转场效果
	0.5,          # 持续时间 duration: float = 0.5
	# 回调函数 callback: Callable = Callable()
	# 自定义效果 custom_transition: BaseTransition = null
	)

func _on_button_yue():
	
	print("以未知角色进行战斗。")	
	scene_manager.change_scene_async(
	game_scene,    # 场景路径
	{"level": 1},               # 场景数据
	true,                       # 保存到栈
	scene_manager.TransitionEffect.FADE,  # 转场效果
	0.5,          # 持续时间 duration: float = 0.5
	# 回调函数 callback: Callable = Callable()
	# 自定义效果 custom_transition: BaseTransition = null
	)


func _on_ri_focus_entered() -> void:
	button_ri.flat = false
	pass # Replace with function body.


func _on_yue_focus_entered() -> void:
	button_yue.flat = true
	pass # Replace with function body.

	button_ri.flat = true
func _on_ri_focus_exited() -> void:
	pass # Replace with function body.
	
func _on_yue_focus_exited() -> void:
	button_yue.flat = false
	pass # Replace with function body.
