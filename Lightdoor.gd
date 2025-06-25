extends Node2D

@export var torches: Array[Node2D] = []  # Drag your torch nodes in the editor

@onready var openingsound = $openingsound
@onready var sprite = $AnimatedSprite2D
@onready var collider = $StaticBody2D/CollisionShape2D

var door_open := false

func _process(_delta):
	if not door_open and _all_torches_lit():
		open_door()

func _all_torches_lit() -> bool:
	for torch in torches:
		if !torch.is_lit:
			return false
	return true

func open_door():
	door_open = true
	openingsound.play()
	collider.call_deferred("set","disabled",true)
	sprite.play("Open")
