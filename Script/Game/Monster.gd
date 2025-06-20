extends Node



@onready var hp_node = $"敌人血量/敌人血量值"
@onready var hpmax_node = $"敌人血量/敌人血量值上限"


@export var 当前异能量 :int
@export var 异能量上限 :int
@export var 当前生命值 :int
@export var 生命值上限 :int
@export var 攻击能力 :int
@export var 闪避能力 :int
@export var 魅力 :int

func _physics_process(delta: float) -> void:
	if hp_node!=null || hpmax_node!=null :
		hp_node.text = str(当前生命值)
		hpmax_node.text = str(生命值上限)

func _ready() -> void:
	get_1级变异者()

func get_1级变异者():
	异能量上限 = Dialogic.VAR.get("1级变异者").get("异能量上限")
	当前异能量 = Dialogic.VAR.get("1级变异者").get("当前异能量")
	当前生命值 = Dialogic.VAR.get("1级变异者").get("当前生命值")
	生命值上限 = Dialogic.VAR.get("1级变异者").get("生命值上限")
	攻击能力 = Dialogic.VAR.get("1级变异者").get("攻击能力")
	闪避能力 = Dialogic.VAR.get("1级变异者").get("闪避能力")
	魅力 = Dialogic.VAR.get("1级变异者").get("魅力")
