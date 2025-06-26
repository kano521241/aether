# 7. 角色类整合所有模块
# Character.gd
extends Node

class_name Character

## 属性
@export var stats: Character_stats
## 被动技能
@export var passive_skills: Array[PassiveSkill] = []
## 主动技能
@export var active_skills: Array[ActiveSkill] = []
## 装备
@export var equipment_manager: EquipmentManager
## 天赋
@export var talent_manager: TalentManager

func _ready() -> void:
	#region 初始化逻辑
	stats = Character_stats.new()
	equipment_manager = EquipmentManager.new()
	talent_manager = TalentManager.new()
	# 初始化被动技能
	_init_passive_skills()
	# 初始化主动技能
	_init_active_skills()
	#endregion
	#region 连接信号
	
	#endregion
	# equipment_manager.connect("equipment_changed", self, "_on_equipment_changed")
	# talent_manager.connect("talent_unlocked", self, "_on_talent_unlocked")
	# talent_manager.connect("talent_upgraded", self, "_on_talent_upgraded")

func _init_passive_skills() -> void:
	# 子类实现，添加具体被动技能
	pass

func _init_active_skills() -> void:
	# 子类实现，添加具体主动技能
	pass

func _on_equipment_changed(slot_index) -> void:
	# 更新角色属性
	_update_stats_from_equipment()

func _on_talent_unlocked(talent) -> void:
	# 应用天赋效果
	talent.apply_effect(stats)

func _update_stats_from_equipment() -> void:
	# 从装备管理器获取加成并更新属性
	stats.set_stat("attack", stats.get_stat("attack_base") + equipment_manager.get_total_bonus("attack"))
	stats.set_stat("defense", stats.get_stat("defense_base") + equipment_manager.get_total_bonus("defense"))
	stats.set_stat("max_health", stats.get_stat("max_health_base") + equipment_manager.get_total_bonus("health"))
	stats.set_stat("speed", stats.get_stat("speed_base") + equipment_manager.get_total_bonus("speed"))

func use_skill(skill_index: int) -> void:
	if skill_index < 0 or skill_index >= active_skills.size():
		return
		
	active_skills[skill_index].cast(self)
	
## 获取所有天赋的加成，并应用天赋效果
func get_talent_bonus() ->void :
	for talent in talent_manager.talent_slots:
		var bonus = Bonus.new()
		bonus.source = talent.talent_name
		bonus.stat_name = talent.stat_type
		bonus.bonus_type = "additive"
		bonus.value = talent.additive_bonus
		stats.add_bonus(bonus)
		bonus.bonus_type = "multiplicative"
		bonus.value = talent.multiplicative_bonus
		stats.add_bonus(bonus)
		talent.apply_effect(stats)
	
	##测试用按钮
func _on_button_down() -> void:
	var resource_manager = CoreSystem.resource_manager
	var t001 = resource_manager.get_cached_resource("res://Resource/Talent/T001.tres")#该资源应该在游戏开始时以字典形式加载，天赋的编号作为键
	talent_manager.add_talent(t001)
	stats.init_bonus_dicts() ##在计算加成前，先清空加成区
	get_talent_bonus()
	var attack = stats.get_stat("attack")
	print("最终攻击="+str(attack))
