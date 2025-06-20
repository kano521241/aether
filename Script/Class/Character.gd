extends Node
##角色类模板,包含了一些角色通用的数据类型

class_name Character


@export var 经验基数 = 100.0      # 一级所需基础经验
@export var 经验增长系数 = 1.2   # 经验增长因子
@export var 角色类型 = 0  #0为玩家，1为npc，2为敌人

@export var 名字 :String
@export var 等级 :int = 1
@export var 升级所需经验值 : int :
	get():
		return _get_exp_to_next_level()
@export var 当前经验值 :int = 0 

@export var 生命值上限 :String
@export var 当前生命值 :String
@export var 能量值上限 :String
@export var 当前能量值 :String

@export var 力量 :int = 1
@export var 智力 :int = 1
@export var 敏捷 :int = 1
@export var 意志 :int = 1
@export var 魅力 :int = 1
@export var 攻击 :int = 1
@export var 格挡 :int = 1
@export var 战略 :int = 1
@export var 统率 :int = 1
@export var data : Dictionary ={}

func _ready() -> void:
	data ={
	"经验基数": 经验基数,
	"名字": 名字,
	"等级": 等级,
	"经验增长系数": 经验增长系数,
	"当前经验值": 当前经验值,
	"生命值上限": 生命值上限,
	"当前生命值": 当前生命值,
	"能量值上限": 能量值上限,
	"当前能量值": 当前能量值,
	"力量": 力量,
	"智力": 智力,
	"敏捷": 敏捷,		
	"意志": 意志,
	"魅力": 魅力,
	"攻击": 攻击,		
	"格挡": 格挡,
	"战略": 战略,
	"统率": 统率,		
	"角色类型":角色类型,
}

func save() -> Dictionary:
	# 返回一个包含要保存状态的字典
	return {
		"经验基数": 经验基数,
		"名字": 名字,
		"等级": 等级,
		"经验增长系数": 经验增长系数,
		"当前经验值": 当前经验值,
		"生命值上限": 生命值上限,
		"当前生命值": 当前生命值,
		"能量值上限": 能量值上限,
		"当前能量值": 当前能量值,
		"力量": 力量,
		"智力": 智力,
		"敏捷": 敏捷,		
		"意志": 意志,
		"魅力": 魅力,
		"攻击": 攻击,		
		"格挡": 格挡,
		"战略": 战略,
		"统率": 统率,		
		"角色类型":角色类型,
		##"collected_items": inventory.get_items() # 假设 inventory 有此方法
	}

func load_data(data: Dictionary) -> void:
	# 从字典恢复状态
	经验基数 = data.get("经验基数", 经验基数)
	名字 = data.get("名字", 名字)  # 修正赋值目标
	等级 = data.get("等级", 等级)
	经验增长系数 = data.get("经验增长系数", 经验增长系数)
	当前经验值 = data.get("当前经验值", 当前经验值)
	生命值上限 = data.get("生命值上限", 生命值上限)
	当前生命值 = data.get("当前生命值", 当前生命值)
	能量值上限 = data.get("能量值上限", 能量值上限)
	当前能量值 = data.get("当前能量值", 当前能量值)
	力量 = data.get("力量", 力量)
	智力 = data.get("智力", 智力)
	敏捷 = data.get("敏捷", 敏捷)
	意志 = data.get("意志", 意志)
	魅力 = data.get("魅力", 魅力)
	攻击 = data.get("攻击", 攻击)
	格挡 = data.get("格挡", 格挡)
	战略 = data.get("战略", 战略)
	统率 = data.get("统率", 统率)
	角色类型 = data.get("角色类型",角色类型)
	# Player.position.x = data.get("position_x", 0.0)
	# Player.position.y = data.get("position_y", 0.0)
	# inventory.load_items(data.get("collected_items", []))



func _level_up():
	if 当前经验值>=升级所需经验值:
		当前经验值-=升级所需经验值
		var new_level = 等级+1
		_set_current_level(new_level) 
		

## 私有方法：计算升级所需经验
func _get_exp_to_next_level() -> int:
	return int(经验基数 * pow(经验增长系数, 等级 - 1))
	
# setter方法：控制等级变化时的逻辑
func _set_current_level(new_level):
	if new_level < 1:
		等级 = 1  # 最低等级为1
	else:
		等级 = new_level
		emit_signal("level_changed", 等级)


# 动态修改角色属性值
func change_state(property_name: String, new_value, cover: bool = false) -> bool:
	# 检查属性是否存在
	if !has(property_name):
		push_error("错误: 角色没有名为 '%s' 的属性" % property_name)
		return false
	# 根据cover参数决定是叠加还是覆盖属性值
	if !cover:
		# 叠加模式：将新值添加到现有值上
		var current_value = get(property_name)
		
		# 根据属性类型执行不同的叠加逻辑
		match typeof(current_value):
			TYPE_INT, TYPE_FLOAT:
				# 数值类型直接相加
				set(property_name, current_value + new_value)
		# 此处给其他数据类型留空
		return false
	else:
		# 覆盖模式：直接用新值替换旧值
		set(property_name, new_value)
	return true

# 自定义检查属性是否存在的方法
func has(property_name: String) -> bool:
	var properties = get_property_list()
	for prop in properties:
		if prop.name == property_name:
			return true
	return false
