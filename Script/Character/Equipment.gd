# 4. 装备模块
# Equipment.gd
extends Resource

class_name Equipment


## 佩戴装备
signal equipped
## 卸除装备
signal unequipped

# 装备部位
var bodyPart: Global.Body
var name: String = "装备名称"
var description: String = "装备描述"
var attack_bonus: int = 0
var defense_bonus: int = 0
var health_bonus: int = 0
var speed_bonus: float = 0.0

var bonus: Dictionary = {
							Global.Stat.ATTACK: 0,
							Global.Stat.DEFENSE: 0,
							Global.Stat.HEALTH: 0,
							Global.Stat.MAX_HEALTH: 0,
							Global.Stat.SPEED: 0
						}


func equip_to(host_stats: Character_stats) -> void:
	host_stats.set_stat("attack", host_stats.get_stat("attack") + attack_bonus)
	host_stats.set_stat("defense", host_stats.get_stat("defense") + defense_bonus)
	host_stats.set_stat("max_health", host_stats.get_stat("max_health") + health_bonus)
	host_stats.set_stat("speed", host_stats.get_stat("speed") + speed_bonus)
	
	emit_signal("equipped")

func unequip_from(host_stats: Character_stats) -> void:
	host_stats.set_stat("attack", host_stats.get_stat("attack") - attack_bonus)
	host_stats.set_stat("defense", host_stats.get_stat("defense") - defense_bonus)
	host_stats.set_stat("max_health", host_stats.get_stat("max_health") - health_bonus)
	host_stats.set_stat("speed", host_stats.get_stat("speed") - speed_bonus)
	
	emit_signal("unequipped")
