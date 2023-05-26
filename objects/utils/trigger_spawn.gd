extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$dieSfx.play()
		await get_tree().create_timer(1).timeout
		Global.restart_current_scene()
