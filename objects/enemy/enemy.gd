extends CharacterBody2D

@export var speed = 30
@onready var raycast_left = $RayCastLeft
@onready var raycast_right = $RayCastRight
@onready var anim_sprite = $AnimatedSprite2D

var direction: Vector2
var right_movement: Vector2 = Vector2.RIGHT
var left_movement: Vector2 = Vector2.LEFT


enum Directions {
	RIGHT, 
	LEFT
}

@export var directions := Directions.RIGHT

signal player_jump_on_top

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if directions == Directions.RIGHT:
		direction = right_movement
	elif directions == Directions.LEFT:
		direction = left_movement

func _physics_process(delta: float) -> void:
	if direction: 
		velocity.x = direction.x * speed
		
		if !raycast_left.is_colliding():
			direction = right_movement
		elif !raycast_right.is_colliding():
			direction = left_movement
	
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		anim_sprite.play("die")
		
		$Area2D.set_deferred("monitorable", false)
		$Area2D.set_deferred("monitoring", false)
		$CollisionShape2D.set_deferred("disabled", true)
		$AreaDie/CollisionShape2D.set_deferred("disabled", true)
		
		emit_signal("player_jump_on_top")
		$DieSFX.play()
		speed = 0
		await get_tree().create_timer(1).timeout
		queue_free()

func _on_area_die_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.game_over = true
