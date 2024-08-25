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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if directions == Directions.RIGHT:
		direction = right_movement
	if directions == Directions.LEFT:
		direction = left_movement

func _physics_process(delta: float) -> void:
	if direction: 
		velocity.x = direction.x * speed
		
		if !raycast_left.is_colliding():
			direction = right_movement
		if !raycast_right.is_colliding():
			direction = left_movement
	
	move_and_slide()

func _on_area_death_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		anim_sprite.play("die")
		
		$AreaDeath.set_collision_layer_value(9, false)
		$AreaDeath.set_collision_mask_value(1, false)
		$AreaKiller.set_collision_mask_value(1, false)
		set_collision_layer_value(4, false)
		set_collision_mask_value(1, false)
		set_collision_mask_value(4, false)
		
		$DieSFX.play()
		speed = 0
		await get_tree().create_timer(1).timeout
		queue_free()
		

func _on_area_killer_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.set_game_over(true)
