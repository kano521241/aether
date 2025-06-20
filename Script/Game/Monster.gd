extends Node



@onready var hp_node = $"敌人血量/敌人血量值"
@onready var hpmax_node = $"敌人血量/敌人血量值上限"

@export var level :int
@export var exp :int

@export var 当前异能量 :int
@export var 异能量上限 :int
@export var 当前生命值 :int
@export var 生命值上限 :int
@export var 攻击能力 :int
@export var 防御能力 :int
@export var 闪避能力 :int
@export var 魅力 :int



func _ready() -> void:
	get_1级变异者()

func get_1级变异者():
	level = 1
	exp = 10
	异能量上限 = 50
	当前异能量 = 50
	当前生命值 = 50
	生命值上限 = 50
	攻击能力 = 10
	防御能力 = 5
	闪避能力 = 0
	魅力 = 0
	
func text_change():
	if hp_node!=null || hpmax_node!=null :
		hp_node.text = str(当前生命值)
		hpmax_node.text = str(生命值上限)
