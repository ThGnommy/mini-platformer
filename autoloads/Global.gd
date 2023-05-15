extends Node

signal diamond_update(value)
signal key_taken

@export var player_has_key = false
@export var game_over = false

var max_diamonds = 13

var diamonds_count: int = 0:
	set(new_value):
		diamonds_count = new_value

func restart_current_scene():
	player_has_key = false
	game_over = false
	set("diamonds_count", 0)
	get_tree().reload_current_scene()
