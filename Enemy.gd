extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var ledgeCheckLeft = $LedgeCheckLeft
onready var ledgeCheckRight = $LedgeCheckRight
onready var sprite = $AnimatedSprite

func _physics_process(delta: float) -> void:
  var found_wall = is_on_wall()
  var found_ledge = not ledgeCheckLeft.is_colliding() or not ledgeCheckRight.is_colliding()
  if found_wall or found_ledge:
    direction *= -1
  velocity = direction * 25
  sprite.flip_h = direction.x > 0
  move_and_slide(velocity)
