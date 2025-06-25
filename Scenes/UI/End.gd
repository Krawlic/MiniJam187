extends Node2D

@onready var death_num = $Control/Deaths/DeathNum
@onready var score_num = $Control/Score/ScoreNum
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.get_node("character").is_movable = false
	death_num.text = str(Global.deaths)
	score_num.text = str(Global.score)
	pass # Replace with function body.

func _on_menubutton_button_up():
	SignalBus.progress_scene.emit(9)
	pass # Replace with function body.
