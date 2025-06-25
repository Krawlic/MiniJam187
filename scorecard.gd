extends Node2D

@onready var sprite = $sprite
@onready var nextbutton = $nextbutton
@onready var perfect = $Perfect
@onready var good = $Good
@onready var okay = $Okay

var mana: Node2D
var level: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_parent().get_parent()
	mana = level.get_node("Flame_Manager")
	
	display_score()
	
	nextbutton.visible = true
	pass # Replace with function body.

func _on_nextbutton_button_up():
	SignalBus.progress_scene.emit(Global.currentlevel + 1)

func display_score():
	if level.large:
		global_position = level.get_node("Player").get_node("character").global_position
	
	if mana.current_mana >= level.level3star:
		sprite.play("3star")
		Global.score += 3
		perfect.play()
	elif mana.current_mana >= level.level2star:
		sprite.play("2star")
		Global.score += 2
		good.play()
	elif mana.current_mana >= level.level1star:
		sprite.play("1star")
		Global.score += 1
		okay.play()
