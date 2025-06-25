extends CharacterBody2D


@export var speed : float = 100.0
@export var jump_velocity: float = -250.0

@onready var personalflame = $personalflame
@onready var animated_sprite : AnimatedSprite2D = $Sprite2D
@onready var playerleft = $playerleft
@onready var playerright = $playerright
@onready var hurt = $hurt
@onready var deathtimer = $deathtimer

const DEFEATBOARD = preload("res://Scenes/UI/defeatboard.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var is_moving: bool = false
var direction: Vector2 = Vector2.ZERO
var player_pos: Vector2 = Vector2.ZERO
@export var is_movable: bool = true
var is_defeated = false

func _ready():
	personalflame.play("default")
	SignalBus.shrink_player.connect(shrink_player)
	SignalBus.defeat_player.connect(_defeat_player)

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	# Handle Jump.
	if is_on_floor() and is_movable:
		land()
		if Input.is_action_just_pressed("jump"):
			jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_movable:
		direction = Input.get_vector("left", "right", "up", "down")
	else:
		direction = Vector2(0,0)
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	player_pos = global_position
	
	move_and_slide()
	update_animation()

func update_animation():
	if not animation_locked and not is_defeated:
		if direction.x != 0:
			is_moving = true
			animated_sprite.play("walk")
			if direction.x > 0:
				animated_sprite.flip_h = false
				var tween := get_tree().create_tween()
				tween.tween_property(personalflame, "global_position", playerleft.global_position, .1)
			elif direction.x < 0:
				animated_sprite.flip_h = true
				var tween := get_tree().create_tween()
				tween.tween_property(personalflame, "global_position", playerright.global_position, .1)
		else:
			animated_sprite.play("idle")
			is_moving = false

func jump():
	is_moving = true
	velocity.y = jump_velocity
	
func land():
	animation_locked = false
	is_moving = false


func _on_area_2d_body_entered(body):
	if body.is_in_group("Pushable"):
			body.collision_layer = 1
			body.collision_mask = 1
			body.call_deferred("set","freeze", true)


func _on_area_2d_body_exited(body):
	if body.is_in_group("Pushable"):
			body.collision_layer = 2
			body.collision_mask = 2
			body.call_deferred("set","freeze", false)

func shrink_player():
	var tween := get_tree().create_tween()
	
	# Shrink the whole player
	tween.tween_property(self, "scale", Vector2.ZERO, 1.0)

	# Fade out the player visually (modulate alpha)
	if has_node("Sprite2D"):
		tween.tween_property($Sprite2D, "modulate:a", 0.0, 1.0)
	elif has_node("AnimatedSprite2D"):
		tween.tween_property($AnimatedSprite2D, "modulate:a", 0.0, 1.0)

func _defeat_player():
	if not is_defeated:
		is_defeated = true
		hurt.play()
		is_movable = false
		deathtimer.start()
		animated_sprite.play("death")
		Global.deaths += 1
		
func _on_deathtimer_timeout():
	var defeat_tmp = DEFEATBOARD.instantiate()
	get_parent().get_parent().call_deferred("add_child", defeat_tmp)
