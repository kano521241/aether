extends Node
## 职业类
class_name Occupation

## 构思
## 职业应该有等级，应该有独特的职业特性，某些职业只能被具有种族特性的角色拥有，某些职业在有的种族上会有额外加成
## 职业根据熟练度划分等级，0-500新手，501-1000熟手，1001-3000精通，3001-5000大师，5001以上则为神话

@export var occupation_name: String = ""  # 职业名称
@export var proficiency: int = 0  # 熟练度
@export var race_restrictions: Array[String] = []  # 种族限制
@export var unique_traits: Array[String] = []  # 独特的职业特性
@export var racial_bonuses: Dictionary = {}  # 种族加成


# 根据熟练度划分等级
func get_rank() -> String:
	if proficiency <= 500:
		return "新手"
	elif proficiency <= 1000:
		return "熟手"
	elif proficiency <= 3000:
		return "精通"
	elif proficiency <= 5000:
		return "大师"
	else:
		return "神话"


# 检查角色是否可以拥有该职业
func can_have_occupation(race: String) -> bool:
	if race_restrictions.size() == 0:
		return true
	return race in race_restrictions


# 获取种族加成
func get_racial_bonus(race: String) -> float:
	if racial_bonuses.has(race):
		return racial_bonuses[race]
	return 0.0


