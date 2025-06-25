extends Node2D

@onready var sprite = $sprite

func _ready():
	sprite.play("default")

func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		SignalBus.defeat_player.emit()
	pass # Replace with function body.
