extends Control

@export var level_scene: PackedScene

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)

func _ready() -> void:
	$PanelContainer/Panel/Buttons/Play.grab_focus()
	
	var SGC = SaveGameAsJson.new()
	
	if SGC.save_file_exists():
		SGC.load_savegame()
	else:
		SGC.write_savegame()

func _on_play_gui_input(event):
	if Input.is_action_just_pressed("UI_Select"):
		get_tree().change_scene_to_packed(level_scene)
