extends Node2D

@export var player: CharacterBody2D

@onready var area_enter = $Enter
@onready var path_follow = $Path2D/PathFollow2D
@export var travel_speed = 50.0

var can_travel: bool = false

var violet: Color = Color(0.5, 0.35, 0.5)

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if can_travel:
		path_follow.progress += travel_speed * delta
		if path_follow.progress_ratio == 1.0:
			player.velocity = Vector2.ZERO
			player.set_physics_process(true)
			
			# scale player up
			var tween = create_tween()
			tween.tween_property(player, "scale", Vector2(1, 1), 0.3)
			
			can_travel = false
			player.reparent(get_parent())
			get_parent().move_child(player, 1)
			path_follow.progress_ratio = 0.0
			$exitPipeSfx.play()

func _on_enter_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.call_deferred("reparent", path_follow)
		body.set_physics_process(false)
		can_travel = true
		# scale player down
		var tween = create_tween()
		tween.tween_property(player, "scale", Vector2(0.5, 0.5), 0.3)
		$enterPipeSfx.play()
