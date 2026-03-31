extends Area2D

# Kill zone - instantly kills the player (falling off map, bottomless pit, etc.)
@onready var game_manager: Node = get_tree().current_scene.get_node("Game Manager")

func _on_body_entered(body: Node2D) -> void:
	if game_manager.hearts > 0:
		game_manager.hearts = 0
		game_manager.player_death()
