extends Control

@onready var debug_label = $Label
@export var _player_velocity: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var str = "Player velocity: x: {x} y: {y}".format({"x": _player_velocity.velocity.x, "y": roundf(_player_velocity.velocity.y)})
	debug_label.set_text(str)
	pass
