extends Node2D

@export var travel_speed = 50.0
@export var curves: Array[Curve2D]
@onready var path2d = $Path2D
@onready var path_follow = $Path2D/PathFollow2D
var start_fly = false

func _ready() -> void:
	path2d.set_curve(curves.pick_random())
	var rnd_number = randf_range(0.5, 5.0)
	await get_tree().create_timer(rnd_number).timeout
	start_fly = true

func _process(delta: float) -> void:
	if start_fly:
		path_follow.progress += travel_speed * delta
		if path_follow.progress_ratio > 0.99:
			get_random_curve()

func get_random_curve() -> void:
	path2d.set_curve(curves.pick_random())
	path_follow.progress_ratio = 0.0
