extends Node
##全局

@export var GameDate:Dictionary

@export var level_max = 99 ##等级上限
@export var attribute_max = 999 ##属性上限

@export var player :Character


signal trigger(index:String) ##触发剧情



func _ready() -> void:
	trigger.connect(Trigger_dialogue)
	pass
	

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
func Trigger_dialogue(index:String) ->void:
	if index == null :
		return 
	else :
		Dialogic.start(index)
		

	
func get_dialogic_variables(var_name:String) ->float:
	var v = $Node.state[var_name]
	if v == null :
		return 0	
	else :
		return $Node.state[var_name]
