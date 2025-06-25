extends Node2D

func _ready():
	var level = get_parent()
	if level.large:
		global_position = level.get_node("Player").get_node("character").global_position
	pass

func _on_restartbutton_button_up():
	SignalBus.progress_scene.emit(Global.currentlevel)
	pass # Replace with function body.
