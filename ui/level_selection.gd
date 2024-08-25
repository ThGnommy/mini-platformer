extends Control

@onready var level_container = $Panel/VBoxContainer2/VBoxContainer/HBoxContainer
@export var level_scene: Array[PackedScene]

func _ready() -> void:
	
	var SGC = SaveGameAsJson.new()
	var level_reached = SGC.get_level_reached()
	
	for button in level_container.get_children():
		button.pressed.connect(_on_button_pressed.bind(button))
		
		if button.get_index() >= level_reached:
			button.disabled = true

func _on_button_pressed(button: Button) -> void:
	# todo: the user can played it only if the level was completed before, the first level is always available
	get_tree().change_scene_to_packed(level_scene[button.get_index()])
