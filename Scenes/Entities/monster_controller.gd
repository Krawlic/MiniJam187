extends Node2D

@onready var monsterbody = $".."

const MONSTER_STONE = preload("res://Scenes/Entities/monster_stone.tscn")

var is_stone = false

func turn_to_stone():
	is_stone = true
	monsterbody.visible = false
	
	monsterbody.queue_free()
	
	var stone = MONSTER_STONE.instantiate()
	stone.global_position = global_position
	get_parent().get_parent().call_deferred("add_child", stone)
	
	pass

func _on_hitbox_2_area_entered(area):
	if area.get_parent().is_in_group("Flame"):
		turn_to_stone()
	if area.get_parent().is_in_group("Player"):
		SignalBus.defeat_player.emit()
	
