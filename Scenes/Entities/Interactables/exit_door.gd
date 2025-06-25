extends Node2D

@onready var timer = $Timer
@onready var exitsound = $exitsound
@onready var sprite = $AnimatedSprite2D
const SCORECARD = preload("res://Scenes/UI/scorecard.tscn")

@export var is_open: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_open:
		sprite.play("Open")
	pass # Replace with function body.

func _on_exit_area_area_entered(area):
	if area.is_in_group("Player") and is_open:
		exitsound.play()
		SignalBus.shrink_player.emit()
		area.get_parent().is_movable = false
		timer.start()
	
func _on_timer_timeout():
	var score_tmp = SCORECARD.instantiate()
	get_parent().get_node("Player").call_deferred("add_child", score_tmp)
