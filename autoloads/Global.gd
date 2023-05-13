extends Node

@export var player_has_key = false
@export var game_over = false

func restart_current_scene():
	get_tree().reload_current_scene()
