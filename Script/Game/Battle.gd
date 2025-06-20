extends Node

@onready var monster_node
@onready var fengyan_node
@onready var ap

func _ready() -> void:
	monster_node = $"敌人"
	fengyan_node = $"状态栏/人物面板/逢炎"
	ap = $"行动点数/AP值"
	ap.text = str(3)
	pass
	
func _physics_process(delta: float) -> void:
	if  int(ap.text) <= 0 :
		monster_attack()
		ap.text = str(3)
	
func monster_attack():
	var harm =  monster_node.攻击能力 - fengyan_node.防御能力
	fengyan_node.当前生命值 -= harm
	pass
