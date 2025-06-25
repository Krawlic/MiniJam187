extends Node2D

@onready var light = $Node2D/light
@onready var sprite = $AnimatedSprite2D
@onready var lightsound = $Lightsound

@export var is_lit := false

func _ready():
	if is_lit:
		light.visible = true
		sprite.play("lit")

func togglelight():
	if not is_lit:
		is_lit = true
		light.visible = true
		sprite.play("lit")
		lightsound.play()
