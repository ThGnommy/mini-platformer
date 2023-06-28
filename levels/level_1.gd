extends Node2D

@onready var _player = $Player

func _ready() -> void:
	Global.connect("victory", _on_victory)
	
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in all_enemies:
		enemy.player_jump_on_top.connect(_player._on_player_jump_on_enemies)

func _on_victory():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
