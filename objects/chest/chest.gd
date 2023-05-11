extends Area2D

@onready var global_vars = get_node("/root/Global")

@onready var letter = $Text
@onready var animated_sprite = $AnimatedSprite2D
var is_in_area = false
@onready var key = $AreaKey
@onready var anim_player = $AnimationPlayer

func _process(delta: float) -> void:
	if animated_sprite.get_frame() == 1:
		letter.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and animated_sprite.get_frame() != 1:
		letter.show()
		is_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		letter.hide()
		is_in_area = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_in_area:
		animated_sprite.set_frame(1)
		key.show()
		key_animation()

func key_animation():
		var tween = create_tween()
		tween.tween_property(key, "scale", Vector2(1, 1), 0.5).set_ease(Tween.EASE_IN_OUT)
		tween.parallel().tween_property(key, "global_position", Vector2(global_position.x, global_position.y - 15), 0.5)
		anim_player.play("key_modulate")

func _on_area_key_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		global_vars.player_has_key = true
		key.queue_free()
