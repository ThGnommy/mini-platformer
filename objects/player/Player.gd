extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var jumpSfx = $jumpSfx

@onready var animated_sprite = $AnimatedSprite2D
@export var spawn_point: Marker2D


func _ready() -> void:
	Global.connect("victory", _on_victory)
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

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
	
	if Global.game_over == true:
		die()

func jump():
	velocity.y = JUMP_VELOCITY
	jumpSfx.play()

# flip character base on horizontal velocity
func flip(vel: float) -> void:
	if vel < 0: 
		animated_sprite.flip_h = true
	elif vel > 0:
		animated_sprite.flip_h = false

func die():
	animated_sprite.play("die")
	$dieSfx.play()
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	Global.restart_current_scene()

func _on_victory():
	$winSfx.play()
	set_physics_process(false)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0)


func _on_player_jump_on_enemies():
	jump()
