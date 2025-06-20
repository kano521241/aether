extends Node

## 为了避免代码冗杂，这个界面仅作跳转到其他界面的功能

@onready var start_button = $"选项界面/开始游戏"
@onready var load_button = $"选项界面/加载游戏"
@onready var exit_button = $"选项界面/退出游戏"
@onready var save_menu = "res://Scenes/UI/存档界面.tscn"
@onready var creat_menu = "res://Scenes/game/主游戏界面.tscn"
@onready var scene_manager =  CoreSystem.scene_manager
@onready var save_manager : CoreSystem.SaveManager =  CoreSystem.save_manager


func _ready():
	# 设置UI元素的初始状态
	start_button.connect("pressed",_on_start_pressed)
	load_button.connect("pressed",_on_load_pressed)
	exit_button.connect("pressed",_on_exit_pressed)
	
	#if not Dialogic.signal_event.is_connected(_on_creat_player): ##检测信号是否已经被绑定，避免重复绑定
		#Dialogic.signal_event.connect(_on_creat_player)##绑定dialogic的信号到方法

#region 按钮	
func _on_start_pressed():
	scene_manager.change_scene_async(
	creat_menu,    # 场景路径
	{"level": 1},               # 场景数据
	true,                       # 保存当前场景
	scene_manager.TransitionEffect.FADE,  # 转场效果
	0.5,          # 持续时间 duration: float = 0.5
	# 回调函数 callback: Callable = Callable()
	# 自定义效果 custom_transition: BaseTransition = null
	)
	
func _on_load_pressed():
	scene_manager.change_scene_async(
	save_menu,    # 场景路径
	{"level": 1},               # 场景数据
	true,                       # 保存到栈
	scene_manager.TransitionEffect.FADE,  # 转场效果
	0.5,          # 持续时间 duration: float = 0.5
	# 回调函数 callback: Callable = Callable()
	# 自定义效果 custom_transition: BaseTransition = null
	)
	


func _on_exit_pressed():
	print("退出游戏")
	get_tree().quit()    
#endregion
	




	
	
