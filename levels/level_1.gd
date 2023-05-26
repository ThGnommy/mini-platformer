extends Node2D

func _ready() -> void:
	Global.connect("victory", _on_victory)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_victory():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
