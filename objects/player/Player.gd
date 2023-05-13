extends CharacterBody2D

class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@export var spawn_point: Marker2D

var tilemap = "res://levels/level_1_tilemap.tres"

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("walk")
		flip(velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	if velocity.y != 0:
		animated_sprite.play("jump")

	move_and_slide()
	
	# debug text
	var str = "Player velocity: x: {x} y: {y}".format({"x": velocity.x, "y": roundf(velocity.y)})
	$Label.set_text(str)

# flip character base on horizontal velocity
func flip(vel: float) -> void:
	if vel < 0: 
		animated_sprite.flip_h = true
	elif vel > 0:
		animated_sprite.flip_h = false

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print(body_shape_index, local_shape_index)
