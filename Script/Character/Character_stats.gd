extends Resource

class_name Character_stats

signal stats_changed(stat_name, new_value)
signal died


@export_group("基础属性（不直接修改，作为计算基准）") 
@export var base_max_health: int = 100
@export var base_attack: int = 10
@export var base_defense: int = 5
@export var base_speed: float = 1.0


@export_group("当前属性值（动态计算）") 
@export var current_health: int = 100

@export_group("加法区") # 各种加成（通过字典管理，支持多个来源）
@export var additive_bonuses = {
	"max_health": 0,
	"attack": 0,
	"defense": 0,
	"speed": 0
}
@export_group("乘法区") # 各种加成（通过字典管理，支持多个来源）
@export var multiplicative_bonuses = {
	"max_health": 1.0,
	"attack": 1.0,
	"defense": 1.0,
	"speed": 1.0
}

# 获取最终属性值（基础 + 加成）
func get_stat(stat_name: String) -> Variant:
	match stat_name:
		"health": 
			return current_health
		"max_health": 
			return calculate_final_value("max_health")
		"attack": 
			return calculate_final_value("attack")
		"defense": 
			return calculate_final_value("defense")
		"speed": 
			return calculate_final_value("speed")
		_: 
			return null

# 计算最终属性值（考虑加法和乘法加成）
func calculate_final_value(stat_name: String) -> Variant:
	var base_value = 0  # 修复：声明并初始化 base_value
	# 获取对应基础属性值
	match stat_name:
		"max_health": base_value = base_max_health
		"attack": base_value = base_attack
		"defense": base_value = base_defense
		"speed": base_value = base_speed
		_: 0
		
	# 先应用加法加成，再应用乘法加成
	var final_value = (base_value + additive_bonuses[stat_name]) * multiplicative_bonuses[stat_name]
	
	# 确保属性值不会低于0
	if stat_name != "speed":  # 速度可以是0（表示无法移动）
		final_value = max(0, final_value)
		
	return final_value

# 添加加成（source 用于标识加成来源，如"talent"、"equipment"）
func add_bonus(stat_name: String, value: float, bonus_type: String = "additive", source: String = "") -> void:
	if not additive_bonuses.has(stat_name) or not multiplicative_bonuses.has(stat_name):
		return
		
	if bonus_type == "additive":
		additive_bonuses[stat_name] += value
	elif bonus_type == "multiplicative":
		multiplicative_bonuses[stat_name] += value  # 乘法加成通常是百分比增加（如0.1表示+10%）
	
	emit_signal("stats_changed", stat_name, get_stat(stat_name))

# 移除加成
func remove_bonus(stat_name: String, value: float, bonus_type: String = "additive", source: String = "") -> void:
	if not additive_bonuses.has(stat_name) or not multiplicative_bonuses.has(stat_name):
		return
		
	if bonus_type == "additive":
		additive_bonuses[stat_name] = max(0, additive_bonuses[stat_name] - value)
	elif bonus_type == "multiplicative":
		multiplicative_bonuses[stat_name] = max(1.0, multiplicative_bonuses[stat_name] - value)
	
	emit_signal("stats_changed", stat_name, get_stat(stat_name))

# 设置基础属性（通常只在初始化或升级时调用）
func set_base_stat(stat_name: String, value: Variant) -> void:
	match stat_name:
		"max_health":
			var old_max = base_max_health
			base_max_health = value
			
			# 如果当前生命值超过新的最大值，调整当前生命值
			if current_health > base_max_health:
				current_health = base_max_health
				
			emit_signal("stats_changed", "max_health", get_stat("max_health"))
			emit_signal("stats_changed", "health", current_health)
		"attack":
			base_attack = value
			emit_signal("stats_changed", "attack", get_stat("attack"))
		"defense":
			base_defense = value
			emit_signal("stats_changed", "defense", get_stat("defense"))
		"speed":
			base_speed = value
			emit_signal("stats_changed", "speed", get_stat("speed"))

# 初始化加成字典的方法
func init_bonus_dicts() -> void:
	# 初始化加法区字典
	for key in additive_bonuses.keys():
		additive_bonuses[key] = 0
	# 初始化乘法区字典
	for key in multiplicative_bonuses.keys():
		multiplicative_bonuses[key] = 1.0
# 其他方法保持不变
func take_damage(amount: int) -> void:
	var actual_damage = max(1, amount - get_stat("defense"))
	current_health = max(0, current_health - actual_damage)
	emit_signal("stats_changed", "health", current_health)
	
	if current_health <= 0:
		emit_signal("died")

func heal(amount: int) -> void:
	current_health = min(get_stat("max_health"), current_health + amount)
	emit_signal("stats_changed", "health", current_health)
