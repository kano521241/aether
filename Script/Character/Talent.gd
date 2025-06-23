# 6. 天赋模块
# Talent.gd
extends Resource

class_name TalentManager

signal talent_unlocked
signal talent_upgraded

var name: String = "天赋名称"
var description: String = "天赋描述"
var max_level: int = 3
var current_level: int = 0
var required_points: int = 1
var required_talents: Array[TalentManager] = []

func can_unlock(talent_manager) -> bool:
	if current_level > 0:
		return false
		
	if talent_manager.get_available_points() < required_points:
		return false
		
	for required_talent in required_talents:
		if required_talent.current_level <= 0:
			return false
			
	return true

func unlock() -> bool:
	if current_level > 0:
		return false
		
	current_level = 1
	emit_signal("talent_unlocked")
	return true

func can_upgrade(talent_manager) -> bool:
	if current_level >= max_level:
		return false
		
	if talent_manager.get_available_points() < required_points:
		return false
		
	return true

func upgrade() -> bool:
	if current_level >= max_level:
		return false
		
	current_level += 1
	emit_signal("talent_upgraded", current_level)
	return true

func apply_effect(host_stats: Character_stats) -> void:
	# 子类实现天赋效果
	pass
