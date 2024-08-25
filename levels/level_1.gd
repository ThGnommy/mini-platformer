extends Node2D

@onready var _player = $Player

func _ready() -> void:
	Global.connect("victory", _on_victory)

func _on_victory():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var SGC = SaveGameAsJson.new()
	SGC.set_level_reached(2)
	SGC.write_savegame()
