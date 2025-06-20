extends CharacterBody2D

@export var move_speed : float = 10
@onready var animation_tree : AnimationTree =$AnimationTree

func _physics_process(delta):	
	velocity = Input.get_vector("left","right","up","down") * move_speed
	animation_tree.set("parameters/Idle/blend_position",velocity.normalized())
	move_and_collide(velocity)
	print(velocity)
	##move_and_slide()
