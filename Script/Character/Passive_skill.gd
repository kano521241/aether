# 2. 被动技能模块
# PassiveSkill.gd
extends Resource

class_name PassiveSkill

signal skill_activated

var name: String = "被动技能"
var description: String = "技能描述"
var is_active: bool = true

func _ready() -> void:
	# 初始化逻辑
	pass

func activate(host_stats: Character_stats) -> void:
	if not is_active:
		return
		
	# 实现被动效果，例如增加攻击力
	host_stats.set_stat("attack", host_stats.get_stat("attack") + 5)
	emit_signal("skill_activated")

func deactivate(host_stats: Character_stats) -> void:
	if not is_active:
		return
		
	# 移除被动效果
	host_stats.set_stat("attack", host_stats.get_stat("attack") - 5)
