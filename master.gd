extends Node2D

@onready var main_camera = $Camera2D

const SPLASH_LOGO = preload("res://splash.tscn")
const LEVEL_0 = preload("res://level_0.tscn")
const LEVEL_1 = preload("res://Level1.tscn")
const LEVEL_2 = preload("res://level_2.tscn")
const LEVEL_3 = preload("res://level_3.tscn")
const LEVEL_4 = preload("res://level_4.tscn")
const LEVEL_5 = preload("res://level_5.tscn")
const LEVEL_6 = preload("res://level_6.tscn")
const LEVEL_7 = preload("res://level_7.tscn")
const ENDSCREEN = preload("res://endscreen.tscn")

func _ready():
	SignalBus.progress_scene.connect(_progress_scene)
	SignalBus.main_camera_off.connect(_main_camera_off)
	var splash_tmp = SPLASH_LOGO.instantiate()
	add_child(splash_tmp)
	pass

func _progress_scene(progress: int):
	#transition_sound.pitch_scale = randf_range(0.5,1.5)
	Global.can_restart = true
	match progress:
		0:
			#transition_sound.play()
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_0.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		1:
			#transition_sound.play()
			Global.currentlevel = 1
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_1.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		2:
			#transition_sound.play()
			Global.currentlevel = 2
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_2.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		3:
			#transition_sound.play()
			Global.currentlevel = 3
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_3.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		4:
			#transition_sound.play()
			Global.currentlevel = 4
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_4.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		5:
			#transition_sound.play()
			Global.currentlevel = 5
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_5.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		6:
			#transition_sound.play()
			Global.currentlevel = 6
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_6.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		7:
			#transition_sound.play()
			Global.currentlevel = 7
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = LEVEL_7.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		8:
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var level_tmp = ENDSCREEN.instantiate()
			self.call_deferred("add_child", level_tmp)
			SignalBus.update_tracking.emit()
		9:
			get_tree().get_root().get_node("Master").get_child(2).queue_free()
			var splash_tmp = SPLASH_LOGO.instantiate()
			self.call_deferred("add_child", splash_tmp)
	pass

func _main_camera_off():
	main_camera.enabled = false
	pass
