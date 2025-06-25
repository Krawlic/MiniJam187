extends Node2D

@onready var sprite = $monsterbody/sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("turn_to_stone")
	pass # Replace with function body.
