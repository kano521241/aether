extends Node

class_name TalentManager

## 天赋发生改变时发出信号
signal talent_changed

## 天赋列表
@export var talent_slots : Array[Talent] = []
## 累计天赋点
@export var talent_point : int = 0

func _ready() -> void:
	talent_changed.connect(self.pt)

## 添加天赋到列表
func add_talent(talent:Talent):
	if talent in talent_slots:
			return false
	talent_slots.append(talent)
	talent_changed.emit()
	return true
## 移除天赋到列表
func remove_talent(talent:Talent):
	talent_slots.erase(talent)
	talent_changed.emit()

func pt():
	print("添加了新的天赋")
