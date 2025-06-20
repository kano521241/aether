extends CharacterBody2D

@export var move_speed : float = 100

@export var gravity : float = 200

func _physics_process(delta):	
	velocity = Input.get_vector("left","right","up","down") * move_speed
	velocity.y += gravity * delta
	move_and_collide(velocity)
	print(velocity)
	#move_and_slide()
