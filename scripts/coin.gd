extends Area2D

# Coin/gem pickup - adds to player score
@onready var game_manager: Node = %"Game Manager"

  func _on_body_entered(body: Node2D) -> void:
	self.get_node("Pickup Sound").play()
	print("+1 coin")
	game_manager.add_point()
	self.visible = false
  	await get_tree().create_timer(0.2).timeout
  	self.queue_free()
