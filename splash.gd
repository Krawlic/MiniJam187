extends Node2D

func _on_startbutton_button_up():
	SignalBus.progress_scene.emit(0)
	pass # Replace with function body.
