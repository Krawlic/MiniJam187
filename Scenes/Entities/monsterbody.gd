extends CharacterBody2D

@export var point_a: Node2D
@export var point_b: Node2D
@export var speed: float = 15

@onready var sprite = $monstersprite2

var target: Vector2
var direction: Vector2

func _ready():
	if point_a and point_b:
		target = point_b.position
		sprite.play("walk")  # Start animation
	else:
		sprite.play("idle")

func _physics_process(_delta):
	# Switch target if close
	if point_a and point_b:
		if global_position.distance_to(target) < 5:
			target = point_b.position if target == point_a.position else point_a.position

		# Calculate direction and velocity
		direction = (target - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

	# Flip sprite based on movement direction
		if abs(direction.x) > 0.1:
			sprite.flip_h = direction.x < 0
