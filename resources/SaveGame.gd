class_name SaveGameAsJson
extends RefCounted

const SAVE_GAME_PATH := "user://savegame.tres"

var level_reached := 1

func _init() -> void:
	FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)

func save_file_exists() -> bool:
	if FileAccess.open(SAVE_GAME_PATH, FileAccess.READ) == null:
		return false
	return true

func write_savegame() -> void:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if file == null:
		printerr("save file error")
		return
	
	var data := {
		"level_reached": level_reached
	}
	
	var json_string := JSON.stringify(data)
	file.store_string(json_string)
	file.close()

func set_level_reached(num: int):
	if get_data().level_reached <= num:
		level_reached = num

func get_data() -> Dictionary:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if file == null:
		printerr("Failed to open save file")

	var content = file.get_as_text()
	file.close()

	var json_result: Dictionary = JSON.parse_string(content)
	if json_result == null:
		printerr("Failed to parse save file")

	return json_result

func get_level_reached() -> int:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if file == null:
		printerr("Failed to open save file")

	var content = file.get_as_text()
	file.close()

	var json_result = JSON.parse_string(content)
	if json_result == null:
		printerr("Failed to parse save file")

	var data: Dictionary = json_result
	return data.level_reached

func load_savegame() -> void:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if file == null:
		printerr("Failed to open save file")
		return

	var content = file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if result == null:
		printerr("Failed to parse save file")
	
	var data: Dictionary = result
	level_reached = data.level_reached
	
	
