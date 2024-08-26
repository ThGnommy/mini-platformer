extends Control

@export var next_level: PackedScene
@onready var player_texture = $Panel/player
@onready var diamond_texture = $Panel/diamond_point
@onready var panel = $Panel
@onready var label_diamonds = $Panel/VBoxContainer3/VBoxContainer2/HBoxContainer2/diamonds
const diamond = preload("res://ui/diamond_texture.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("victory", _on_victory)
	hide()
	
func _on_victory(): 
	show()
	$Panel/VBoxContainer3/HBoxContainer/VBoxContainer/NextLevel.grab_focus()
	
	for d in Global.diamonds_count:
		var n = d + 1
		_instantiate_diamond(n)
		await get_tree().create_timer(0.3).timeout

func _instantiate_diamond(d):
	const offset = 10
	var diamond_instance = diamond.instantiate()
	panel.add_child(diamond_instance)
	var player_texture_pos = player_texture.get_screen_position()
	var diamond_texture_pos = diamond_texture.position
	var pos_x = player_texture_pos.x + player_texture.get_rect().size.x / 3
	var pos_y = player_texture_pos.y + player_texture.get_rect().size.y + offset
	diamond_instance.set_global_position(Vector2(pos_x, pos_y))

	var tween = create_tween()
	tween.tween_property(diamond_instance, "position", diamond_texture_pos, 0.70).set_ease(Tween.EASE_OUT_IN)
	tween.parallel().tween_property(diamond_instance, "scale", Vector2.ZERO, 0.35).set_delay(0.35)
	tween.parallel().tween_callback(update_score.bind(d)).set_delay(0.60)
	tween.parallel().tween_callback(_play_pickup_sfx).set_delay(0.60)
func update_score(d):
	label_diamonds.text = "{x} / {y}".format({"x": d, "y": Global.max_diamonds})


func _play_pickup_sfx() -> void:
	$pickupSfx.play()

func _on_retry_pressed() -> void:
	Global.restart_current_scene()


func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_packed(next_level)
