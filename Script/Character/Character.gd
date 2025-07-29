# 7. 角色类整合所有模块
# Character.gd
extends Node

class_name Character


# 属性
@export var stat: Dictionary = {
								   Global.Stat.ATTACK: 0,
								   Global.Stat.DEFENSE: 0,
								   Global.Stat.HEALTH: 0,
								   Global.Stat.SPEED: 0
							   }

# 装备
# 当角色触发装备行为，将会使用装备方法，脱下时则触发卸下方法，直接更改角色数据
# 天赋
@export var talent_manager: TalentManager


# 身体部位
@export var body: Dictionary = {
								   Global.Body.HEAD: null,
								   Global.Body.BODY: null,
								   Global.Body.LEFT_HAND: null,
								   Global.Body.RIGHT_HAND: null,
								   Global.Body.LEGS: null
							   }


# 穿上装备
func equipment_put(equipment: Equipment):
	if body(equipment.bodyPart) == null:
		#穿上装备
		return
	#已有装备
	return


# 脱下装备
func equipment_take(equipment: Equipment):
	pass



##测试用按钮
func _on_button_down() -> void:
	# var resource_manager = CoreSystem.resource_manager
	# var t001             = resource_manager.get_cached_resource("res://Resource/Talent/T001.tres")#该资源应该在游戏开始时以字典形式加载，天赋的编号作为键
	# talent_manager.add_talent(t001)
	# stats.init_bonus_dicts() ##在计算加成前，先清空加成区
	# get_talent_bonus()
	# var attack = stats.get_stat("attack")
	# print("最终攻击="+str(attack))
	pass
