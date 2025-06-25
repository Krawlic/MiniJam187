extends Node2D

@onready var stonetimer = $monsterbody/stonetimer
@onready var monsterbody = $monsterbody
const MONSTER_STONE = preload("res://Scenes/Entities/NPCs/Monster_Stone/monster_stone.tscn")

var is_stone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hitbox_area_entered(area):
	if area.get_parent().name == "Flame":
		turn_to_stone()
	
func turn_to_stone():
	is_stone = true
	monsterbody.visible = false
	
	var stone = MONSTER_STONE.instantiate()
	stone.global_position = position
	get_parent().call_deferred("add_child", stone)
	stonetimer.start()
	
	self.queue_free()
	pass
