extends Node

@onready var hp
@onready var mp
@onready var monster
@onready var ap
@onready var fsx

@export var 当前异能量 :int
@export var 异能量上限 :int
@export var 当前生命值 :int
@export var 生命值上限 :int
@export var 攻击能力 :int
@export var 防御能力 :int
@export var 闪避能力 :int
@export var 魅力 :int

func _ready() -> void:
	hp = $"VBoxContainer/血条"
	mp = $"VBoxContainer/能量条"
	monster = $"../../../敌人"
	ap = $"../../../行动点数/AP值"
	fsx = $"../../../音效"
	get_var()
	EventSystem.player_dead.connect(dead)

func _physics_process(delta) -> void:
	if hp!=null ||mp!=null :
		if 当前生命值 <= 0 :
			EventSystem.player_dead.emit() #作为观察者模式的案例，后续会删除
		hp.value = 当前生命值
		mp.value = 当前异能量
		hp.max_value = 生命值上限
		mp.max_value = 异能量上限
	

func get_var():
	异能量上限 = Dialogic.VAR.get("逢炎").get("异能量上限")
	当前异能量 = Dialogic.VAR.get("逢炎").get("当前异能量")
	当前生命值 = Dialogic.VAR.get("逢炎").get("当前生命值")
	生命值上限 = Dialogic.VAR.get("逢炎").get("生命值上限")
	攻击能力 = Dialogic.VAR.get("逢炎").get("攻击能力")
	防御能力 = Dialogic.VAR.get("逢炎").get("防御能力")
	闪避能力 = Dialogic.VAR.get("逢炎").get("闪避能力")
	魅力 = Dialogic.VAR.get("逢炎").get("魅力")

var sound_player = AudioStreamPlayer.new()

func dead() :
	print("玩家死亡！")

func _on_武士刀攻击() -> void:
	var harm =  攻击能力 * 1.5
	if int(ap.text) < 1:
		return
	if 当前异能量 >= 10 :
		harm += 10
		当前异能量 -= 10
		当前生命值 -= 50
	fsx.stream = load("res://Music/SFX/长刀劈砍声.wav")
	fsx.play()
	## PS：后面最好弄个全局的音频播放器
	monster.当前生命值 -= harm
	ap.text = str(int(ap.text) - 1)
