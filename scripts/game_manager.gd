extends Node

# Snow Level Game Manager - mirrors castle level game_manager.gd
# Handles hearts (health), score (coins), lives, death, and pause menu

var hearts = 3
var score = 0
var lives = 3

@onready var player: CharacterBody2D = %"Player"
@onready var pause_menu = player.get_node("UI/pause_menu")
@onready var player_spawn: Marker2D = %"Initial_spawn"

var selected_menu
var selected_menu_index = 0
var movement_is_blocked = false

func _ready():
	# Set up heart UI
	for i in range(3):
		player.get_node("UI/Health/Hearts").get_child(i).visible = true
	player.get_node("UI/Health/Lives/Lives_count").text = "x" + str(lives)
	player.get_node("UI/Coins/Coins_counter").text = "x" + str(score)
	player.global_position = player_spawn.global_position
	player.get_node("Camera2D").enabled = true

func _process(delta: float) -> void:
	# Pause menu navigation
	var direction = Input.get_axis("move_up", "move_down")
	if not movement_is_blocked and pause_menu.visible == true and pause_menu.get_node("pause_selections").visible == true:
		if direction > 0:
			selected_menu_index += 1
		elif direction < 0:
			selected_menu_index -= 1
		selected_menu_index = clamp(selected_menu_index, 0, pause_menu.get_node("pause_selections").get_child_count() - 1)
		selected_menu = pause_menu.get_node("pause_selections").get_child(selected_menu_index)
		pause_menu.get_node("select_icon").global_position = selected_menu.global_position + Vector2(0, 0)
		movement_is_blocked = true
		await get_tree().create_timer(0.35).timeout
		movement_is_blocked = false

	# Confirm selection
	if Input.is_action_just_pressed("confirm"):
		if pause_menu.visible == true and pause_menu.get_node("pause_selections").visible == true:
			match selected_menu.name:
				"pause_resume":
					get_tree().paused = false
					pause_menu.visible = false
				"pause_quit":
					get_tree().paused = false
					get_tree().change_scene_to_file("res://scenes/snow_level.tscn")

	# Toggle pause menu
	if Input.is_action_just_pressed("escape"):
		if pause_menu.visible == true:
			get_tree().paused = false
			pause_menu.visible = false
		else:
			get_tree().paused = true
			pause_menu.visible = true
			selected_menu_index = 0
			selected_menu = pause_menu.get_node("pause_selections").get_child(selected_menu_index)
			pause_menu.get_node("select_icon").global_position = selected_menu.global_position + Vector2(0, 0)

func add_point():
	score += 1
	print(score)
	player.get_node("UI/Coins/Coins_counter").text = "x" + str(score)

func take_damage(): # called by harm_zone.gd
	hearts -= 1
	player.get_node("UI/Health/Hearts").get_child(hearts).visible = false
	print("Hit by enemy")
	print("Hearts left: ", hearts)
	if hearts <= 0:
		print("You are dead")
		player_death()
	else:
		print("Hit by enemy")
		print("Hearts left: ", hearts)

func player_death():
	Engine.time_scale = 0.5
	await get_tree().create_timer(0.5).timeout
	lives -= 1
	print("Lives: ", lives)
	if lives > 0:
		_ready()
	else:
		get_tree().reload_current_scene()
		print("Game Over")
	Engine.time_scale = 1.0
