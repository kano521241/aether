extends Resource

class_name Character_stats


signal stats_changed(stat_name, new_value)

var max_health: int = 100
var current_health: int = 100
var attack: int = 10
var defense: int = 5
var speed: float = 1.0

func take_damage(amount: int) -> void:
	var actual_damage = max(1, amount - defense)
	current_health = max(0, current_health - actual_damage)
	emit_signal("stats_changed", "health", current_health)
	
	if current_health <= 0:
		emit_signal("died")

func heal(amount: int) -> void:
	current_health = min(max_health, current_health + amount)
	emit_signal("stats_changed", "health", current_health)

func get_stat(stat_name: String) -> Variant:
	match stat_name:
		"health": 
			return current_health
		"max_health": 
			return max_health
		"attack": 
			return attack
		"defense": 
			return defense
		"speed": 
			return speed
		_: return null

func set_stat(stat_name: String, value: Variant) -> void:
	match stat_name:
		"health":
			current_health = clamp(value, 0, max_health)
			emit_signal("stats_changed", "health", current_health)
		"max_health":
			max_health = value
			emit_signal("stats_changed", "max_health", max_health)
		"attack":
			attack = value
			emit_signal("stats_changed", "attack", attack)
		"defense":
			defense = value
			emit_signal("stats_changed", "defense", defense)
		"speed":
			speed = value
			emit_signal("stats_changed", "speed", speed)
