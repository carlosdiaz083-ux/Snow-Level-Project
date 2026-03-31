extends CharacterBody2D

# Snow level player script
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var is_attacking = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: Sprite2D = $sword
@onready var sword_attacks: AnimatedSprite2D = $sword_attacks
@onready var stab_collision: CollisionShape2D = $sword_attacks/stab_area/stab_collision
@onready var swing_collision: CollisionShape2D = $sword_attacks/swing_area/swing_collision
@onready var game_manager: Node = %"Game Manager"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite.flip_h = false
		sword.flip_h = false
		sword_attacks.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		sword.flip_h = true
		sword_attacks.flip_h = true

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if not is_attacking:
		if is_on_floor():
			if direction != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("jump")

func stab(s):
	if not is_attacking:
		is_attacking = true
		animated_sprite.play("stab")
		sword_attacks.play("stab")
		stab_collision.disabled = false
		swing_collision.disabled = true
		await animated_sprite.animation_finished
		stab_collision.disabled = true
		is_attacking = false

func swing(s):
	if not is_attacking:
		is_attacking = true
		animated_sprite.play("swing")
		sword_attacks.play("swing")
		swing_collision.disabled = false
		stab_collision.disabled = true
		await animated_sprite.animation_finished
		swing_collision.disabled = true
		is_attacking = false
