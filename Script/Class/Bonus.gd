extends Node
## 加成

class_name Bonus

@export var stat_name: String = "max_health"  # 统计名称
@export var value: float = 0  # 值
## additive|multiplicative
@export var bonus_type: String = "additive"  # 加成
@export var source: String = ""  # 来源