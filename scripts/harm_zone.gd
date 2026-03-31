extends Area2D

# Harm zone - damages the player on contact (spikes, ice hazards, etc.)
@onready var game_manager: Node = get_tree().current_scene.get_node("Game Manager")

  func _on_body_entered(body: Node2D) -> void:
	if game_manager.hearts > 0:
		game_manager.take_damage()
  		body.apply_knockback(global_position)
