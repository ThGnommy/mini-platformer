extends Area2D

@onready var global_vars = get_node("/root/Global")

@onready var label = $Text
@onready var animated_sprite = $AnimatedSprite2D

var is_in_area = false
var door_is_open = false

func _ready() -> void:
	label.text = "open"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and animated_sprite.get_frame() != 1:
		label.show()
		is_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.hide()
		is_in_area = false

func _unhandled_input(event: InputEvent) -> void:
	
	if !global_vars.player_has_key: return

	if event.is_action_pressed("interact") and is_in_area and !door_is_open:
		animated_sprite.play("default")

func _on_animated_sprite_2d_animation_finished() -> void:
	door_is_open = true
	label.set_text("enter")
