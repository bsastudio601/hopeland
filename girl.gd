extends CharacterBody2D

const SPEED = 50
var facing_left = false
var on_stairs = false

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		direction.x = -1

	if Input.is_action_pressed("move_right"):
		direction.x = 1

	if Input.is_action_pressed("move_up"):
		direction.y = -1

	if Input.is_action_pressed("move_down"):
		direction.y = 1

	if direction != Vector2.ZERO:
		if on_stairs:
			if direction.x > 0:
				direction.y = -1
			elif direction.x < 0:
				direction.y = 1

		velocity = direction.normalized() * SPEED

		if direction.x < 0:
			sprite.play("walkleft")
			facing_left = true 

		elif direction.x > 0:
			sprite.play("walkright")
			facing_left = false

		elif direction.y < 0:
			sprite.play("walkup")

		elif direction.y > 0:
			sprite.play("walkdown")

	else:
		velocity = Vector2.ZERO
		
		if facing_left:
			sprite.play("idleleft")
		else:
			sprite.play("idleright")

	move_and_slide()
