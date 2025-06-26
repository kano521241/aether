# 6. 天赋模块
# Talent.gd
extends Resource

class_name Talent

@export_group("Main|主要")
@export var talent_name: String = "天赋名称"
#@export var talent_index:String = "天赋编号"
@export var description: String = "天赋描述"

@export_group("Required|所需条件")
@export var required_points : int = 1
@export var required_talents: Array[Talent] = []  # 必须解锁的前置天赋

# 效果配置（编辑器可配，根据需求扩展，后期应改为Effect类的数组形式，实现一个天赋加成多个属性）
@export_group("Effect|效果")
@export var stat_type: String = "attack"  # 要修改的属性类型（health/attack等）
@export var additive_bonus: float = 0.0  # 加法加成
@export var multiplicative_bonus: float = 1.0  # 乘法加成

# 虚函数：子类可重写，也可直接用配置
func apply_effect(host_stats: Character_stats) -> void:
	pass
	# 进阶逻辑，简单的逻辑可以根据天赋编号来进行math分配，复杂的使用子类实现
# 新增：移除天赋效果（与 apply_effect 相反操作）
func remove_effect(host_stats: Character_stats) -> void:
	pass
