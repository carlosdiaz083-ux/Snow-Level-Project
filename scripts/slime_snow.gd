extends Node2D

# Snow Slime enemy - walks back and forth on platforms
# Snow-themed equivalent of slime_green.gd

const SPEED = 50  # Slightly slower on snow/ice terrain
var direction = 1

@onready var ray_cast_right: RayCast2D = $AnimatedSprite2D/RayCastRight
@onready var ray_cast_left: RayCast2D = $AnimatedSprite2D/RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("walk")

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
