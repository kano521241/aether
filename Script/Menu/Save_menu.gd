extends Node
## 每当打开界面的时候，自动读取存档
## 为了减少工作量，全程只使用一个存档，当开始新游戏时，将会覆盖旧存档，但全局信息会保留


@onready var scene_manager :CoreSystem.SceneManager =  CoreSystem.scene_manager
@onready var save_manager : CoreSystem.SaveManager =  CoreSystem.save_manager

func _ready():
	save()
	## 读档
	load_save()
	
	
func save():
	## 存档
	save_manager.create_save("GameSave")
	print("存档成功")

func load_save():
	## 读取存档
	if !await save_manager.load_save("GameSave"):
		print("加载存档 '" + "GameSave" + "' 失败或存档为空。")
		pass##加载存档失败，要找出原因
		## 转场 返回开始界面
		
		return
	print("加载存档 '" + "GameSave" + "' 成功。")
	##转场 开始游戏
	
	return

func saveable(node :Node):
	## 注册节点
	save_manager.register_saveable_node(node)
