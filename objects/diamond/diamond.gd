extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0,0), .3)
		tween.parallel().tween_property(self, "global_position", Vector2(global_position.x, global_position.y + -10), .3)
		tween.tween_callback(destroy)

func destroy() -> void:
	queue_free()
