class_name Player
extends KinematicBody2D

var velocity = Vector2.ZERO
export (int) var MAX_SPEED = 50
export (int) var FRICTION = 10
export (int) var GRAVITY = 4
export (int) var JUMP_FORCE = -70
export (int) var JUMP_HEIGHT = -130

func _ready() -> void:
  pass 
  
func _physics_process(delta: float) -> void:
  var input = Vector2.ZERO
  apply_gravity()
  input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  if input.x == 0:
    apply_friction()
    $AnimatedSprite.animation ="idle"
  else:
    apply_acceleration(input.x)
    $AnimatedSprite.animation ="walk"
  $AnimatedSprite.flip_h = input.x > 0
  if is_on_floor():
    if Input.is_action_just_pressed("ui_up"):
      velocity.y = JUMP_HEIGHT
  else:
    if Input.is_action_just_released("ui_up") and velocity.y < JUMP_FORCE:
      velocity.y = JUMP_FORCE
  velocity = move_and_slide(velocity, Vector2.UP)

func apply_gravity() -> void:
  velocity.y += GRAVITY

func apply_friction() -> void:
  velocity.x  = move_toward(velocity.x, 0, FRICTION)

func apply_acceleration(amount) -> void:
  velocity.x  = move_toward(velocity.x, MAX_SPEED * amount, 15)
