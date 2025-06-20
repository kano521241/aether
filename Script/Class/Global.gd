extends Node
##全局变量

#@export var modern_save:Save##当前读取的存档
#@export var 暴击系数:float = 0.03
#@export var 闪避系数:float = 0.05
@onready var save_manager : CoreSystem.SaveManager =  CoreSystem.save_manager
@export var player :Character

func _ready() -> void:
	player = Character.new()
	#player._ready()
	save_manager.register_saveable_node(self)  ##似乎只能注册场景树下的节点，player会找不到路径
	
func save() -> Dictionary:
	# 返回一个包含要保存状态的字典,把所有要保存的都存进去
	return {
		"玩家力量": player.力量,
	}

func load_data(data: Dictionary) -> void:
	# 从字典恢复状态
	player.data = data.get("玩家力量", player.data)
	
	# Player.position.x = data.get("position_x", 0.0)
	# Player.position.y = data.get("position_y", 0.0)
	# inventory.load_items(data.get("collected_items", []))
# 判断是否暴击成功
#func calculate_暴击(character:Character) -> bool :
	#if not character.state.has("暴击率") or not character.state.has("敏捷"):
		#print("错误：角色状态中缺少暴击率或敏捷属性")
		#return false
	#var probability : float = character.state["暴击率"] # 暴击概率
	#probability += character.state["敏捷"] * Global.暴击系数 # 每点敏捷带来3%的暴击率提升
	#return Global.check_probability(probability)
	#
##计算战斗双方中，防守方的闪避率，并返回float值
#func calculate_闪避(a:Character,b:Character) -> bool :
	#if not a.state.has("敏捷") or not b.state.has("敏捷") or not b.state.has("闪避率"):
		#print("错误：角色状态中缺少闪避率或敏捷属性")
		#return false
	## a为攻击方，b为防御方
	#var probability : float = b.state["闪避率"] # 闪避概率
	#var delta = a.state["敏捷"] - b.state["敏捷"]
	#if delta <= 0 :
		#probability += min(delta * Global.闪避系数 , 0.09) * 100 # 每点敏捷差值带来5%的闪避率提升，最多90%
	#return Global.check_probability(probability)
#
#
## 判断概率事件是否触发
#func check_probability(probability: float) -> bool:
	#var rng = RandomNumberGenerator.new()
	#var random_value = rng.randf()
	#if random_value < probability :
		#return true
	#else :
		#return false

# 触发对话
func Trigger_dialogue(对话内容:String) ->void:
	if 对话内容 == null :
		return 
	else :
		Dialogic.start(对话内容)
		
		
func get_dialogic_variables(var_name:String) ->float:
	var v = $Node.state[var_name]
	if v == null :
		return 0	
	else :
		return $Node.state[var_name]
