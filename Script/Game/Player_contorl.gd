extends CharacterBody2D

@export var move_speed : float = 2
@onready var animation_tree : AnimationTree =$AnimationTree
@onready var animated_sprite_2d: Sprite2D = $AnimatedSprite2D
@export var animation_stat :Animation_stat = Animation_stat.is_idle
@onready var attack_cd: Timer = $Attack_cd
@export var is_attacking = true
#向量变量，用作人物的动画移动
var vector = 10

const ATTACK_AREA_SWORD = preload("res://Scenes/character/Attack/attack_area_sword.tscn")

func _ready() -> void:
	attack_cd.timeout.connect(end_attack)

func _physics_process(_delta):
	move()
	update_animation_parameters()

func move() ->void:
	## 如果正在攻击，无法进行移动，以及转向
	if !is_attacking:
		return
	# 获取输入向量，计算移动速度
	velocity = Input.get_vector("left","right","up","down") * move_speed
	var collision = move_and_collide(velocity)
	# 处理精灵翻转
	if velocity.x >0 :
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0 :
		animated_sprite_2d.flip_h = true
	# 执行移动与碰撞
	# move_and_collide(velocity)
	
	
func update_animation_parameters():

	# 设置 idle 条件：速度为 0 时触发 idle 动画
	if (velocity == Vector2.ZERO): 
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/run"] = false
	# 设置 run 条件：速度不为 0 时触发 run 动画
	else :
			animation_tree["parameters/conditions/idle"] = false
			animation_tree["parameters/conditions/run"] = true
	## 如果不可以攻击，直接跳出这个方法
	if !is_attacking:
		
		return 
	if Input.is_action_just_pressed("attack"):
		if is_attacking :
			attack_cd.wait_time = 1.0  ##此处应该用人物的攻击速度代替
			attack_cd.start()

			animation_tree["parameters/conditions/attack"] = true
			is_attacking = false
			velocity = Vector2.ZERO
			
		
func end_attack():
	animation_tree["parameters/conditions/attack"] = false
	is_attacking = true
	
func attack_move():
	if animated_sprite_2d.flip_h:
		vector = -abs(vector)
	else :
		vector = abs(vector)
	var v = Vector2(vector,0)
	move_and_collide(v)


enum  Animation_stat {
	is_idle,
	is_run,
	is_attack,
}
