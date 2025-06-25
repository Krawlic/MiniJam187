extends Node

var currentlevel = 0
var can_restart = false
var score = 0
var deaths = 0

func _unhandled_input(event):
	if can_restart and event is InputEventKey and not event.pressed and event.keycode == KEY_R:
		SignalBus.progress_scene.emit(currentlevel)
