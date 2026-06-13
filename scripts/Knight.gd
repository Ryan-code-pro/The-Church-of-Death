extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation
	if not is_on_floor():
		sprite.play("Jump")
	elif direction != 0:
		if Input.is_action_just_pressed("Attack"):
			sprite.play("Dash")
		else:
			sprite.play("Run")
	else:
		sprite.play("Idle")

	move_and_slide()
	if Input.is_action_just_pressed("Attack"):
		sprite.play("Attack")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
