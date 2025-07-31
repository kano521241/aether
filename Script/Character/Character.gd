# 7. 角色类整合所有模块
# Character.gd
extends Node2D


class_name Character

@export var character_name: String
## 属性
@export var stats: Character_stats = Character_stats.new()
## 被动技能
@export var passive_skills: Array[PassiveSkill] = []
## 主动技能
@export var active_skills: Array[ActiveSkill] = []
## 装备
@export var equipment_manager: EquipmentManager = EquipmentManager.new()
## 天赋
@export var talent_manager: TalentManager = TalentManager.new()

@export var attack_arc_scene: PackedScene  # 引用攻击区域
@export var attack_offset: Vector2 = Vector2(50, 0)  # 攻击区域相对于角色的偏移



func _ready() -> void:
	#region 初始化逻辑
	# 初始化被动技能
	_init_passive_skills()
	# 初始化主动技能
	_init_active_skills()
	attack_arc_scene = CoreSystem.resource_manager.load_resource("res://Scenes/character/Attack/attack_area_sword.tscn")
	#endregion
	#region 连接信号
	
	#endregion
	# equipment_manager.connect("equipment_changed", self, "_on_equipment_changed")
	# talent_manager.connect("talent_unlocked", self, "_on_talent_unlocked")
	# talent_manager.connect("talent_upgraded", self, "_on_talent_upgraded")

# func _input(event: InputEvent) -> void:
# 	# 检测 K 键按下
# 	if event is InputEventKey and event.pressed and event.keycode == KEY_K:
# 		attack()  # 触发攻击
		
func _init_passive_skills() -> void:
	# 子类实现，添加具体被动技能
	pass

func _init_active_skills() -> void:
	# 子类实现，添加具体主动技能
	pass
	
	
	

@onready var animated_sprite_2d: Sprite2D = $"../AnimatedSprite2D"

## 攻击逻辑
func attack() -> void:
	
		# 获取当前角色的flipH状态
	var is_flipped = animated_sprite_2d.flip_h  # 这里假设角色有一个名为sprite的Sprite2D或者AnimatedSprite2D节点用于显示外观
	var attack_rotation = 0.0
	
	if is_flipped:
		# 如果角色水平翻转，设置攻击方向为向左（这里以弧度制为例，向左是pi弧度）
		attack_rotation = PI
	else:
		# 角色未翻转，攻击方向为向右（0弧度）
		attack_rotation = 0.0
		
		# 实例化攻击区域
	var arc = attack_arc_scene.instantiate()

	get_parent().add_child(arc)
	print("发动攻击")
	pass
	
## 翻滚逻辑
func roll() -> void:
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
	var t001 = resource_manager.load_resource("res://Resource/Talent/T001.tres")#该资源应该在游戏开始时以字典形式加载，天赋的编号作为键
	talent_manager.add_talent(t001)
	stats.init_bonus_dicts() ##在计算加成前，先清空加成区
	get_talent_bonus()
	var attack = stats.get_stat("attack")
	print("最终攻击="+str(attack))
	Global.trigger.emit("D0003")
