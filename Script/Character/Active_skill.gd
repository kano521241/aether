# 3. 主动技能模块
# ActiveSkill.gd
extends Node

class_name ActiveSkill

signal skill_cast_started
signal skill_cast_ended
signal skill_cooldown_started
signal skill_cooldown_ended

var skill_name: String = "主动技能"
var description: String = "技能描述"
var cooldown: float = 5.0
var mana_cost: int = 10
var cast_time: float = 0.0
var is_casting: bool = false
var is_on_cooldown: bool = false
var cooldown_remaining: float = 0.0

func _ready() -> void:
	pass

func can_cast(caster_stats: Character_stats) -> bool:
	if is_casting or is_on_cooldown:
		return false
		
	if caster_stats.get_stat("mana") < mana_cost:
		return false
		
	return true

func cast(caster: Node) -> void:
	if not can_cast(caster.stats):
		return
		
	if cast_time > 0:
		is_casting = true
		emit_signal("skill_cast_started")
		await get_tree().create_timer(cast_time).timeout
		is_casting = false
		
	# 实际释放技能
	_execute(caster)
	
	# 进入冷却
	is_on_cooldown = true
	cooldown_remaining = cooldown
	emit_signal("skill_cooldown_started", cooldown)
	
	# 启动冷却计时器
	await get_tree().create_timer(cooldown).timeout
	is_on_cooldown = false
	emit_signal("skill_cooldown_ended")

func _execute(caster: Node) -> void:
	# 子类实现具体技能效果
	pass

func update(delta: float) -> void:
	if is_on_cooldown:
		cooldown_remaining = max(0, cooldown_remaining - delta)
