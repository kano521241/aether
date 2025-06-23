# 5. 装备管理器
# EquipmentManager.gd
extends Node

class_name EquipmentManager

signal equipment_changed(slot_index)

var equipment_slots: Array[Equipment] = []
var slot_types: Array[int] = []

func _ready() -> void:
	# 初始化装备槽
	for i in range(5):  # 假设5个装备槽
		equipment_slots.append(null)
		# slot_types.append(EQUIPMENT_TYPE.WEAPON + i)
		pass

func can_equip(equipment: Equipment, slot_index: int) -> bool:
	if slot_index < 0 or slot_index >= equipment_slots.size():
		return false
		
	if equipment.type != slot_types[slot_index]:
		return false
		
	return true

func equip(equipment: Equipment, slot_index: int) -> bool:
	if not can_equip(equipment, slot_index):
		return false
		
	# 如果已有装备，先卸下
	if equipment_slots[slot_index]:
		unequip(slot_index)
		
	equipment_slots[slot_index] = equipment
	emit_signal("equipment_changed", slot_index)
	return true

func unequip(slot_index: int) -> Equipment:
	var old_equipment = equipment_slots[slot_index]
	equipment_slots[slot_index] = null
	emit_signal("equipment_changed", slot_index)
	return old_equipment

func get_total_bonus(stat_name: String) -> Variant:
	var total = 0
	
	for equipment in equipment_slots:
		if not equipment:
			continue
			
		match stat_name:
			"attack": total += equipment.attack_bonus
			"defense": total += equipment.defense_bonus
			"health": total += equipment.health_bonus
			"speed": total += equipment.speed_bonus
			_: pass
			
	return total
