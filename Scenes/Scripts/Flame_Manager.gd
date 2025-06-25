extends Node2D

@export var max_mana: int = 5
var current_mana: int = max_mana

var flame_instance: Node2D = null
const flame_scene = preload("res://Scenes/Entities/Player/flame.tscn")
var active_glow: Node2D = null
var active_flames: Array[Node2D] = []
@export var player: Node2D
@export var line_color: Color = Color.WHITE
@export var max_distance: float = 100.0 
var is_in_range = false

func _ready():
	player = get_parent().get_node("Player")

func _unhandled_input(event):
	if is_in_range and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if current_mana > 0:
			var click_pos = get_global_mouse_position()
			var torch = get_torch_under_mouse(click_pos)
			if torch:
				light_torch(torch)
			else:
				spawn_flame(click_pos)

func get_torch_under_mouse(pos: Vector2) -> Node:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results = space_state.intersect_point(query, 5)

	for result in results:
		var node = result["collider"].get_parent()
		if node and node.is_in_group("Torch"):
			return node
	return null

func light_torch(torch):
	if torch.has_method("togglelight") and not torch.is_lit:
		torch.togglelight()
		use_mana()

func spawn_flame(pos: Vector2):
	var flame = flame_scene.instantiate()
	flame.global_position = pos
	add_child(flame)
	active_flames.append(flame)
	use_mana()

func _process(_delta):
	queue_redraw()
	pass
	
func use_mana():
	if current_mana > 0:
		current_mana -= 1
		update_mana_sprite()
		# Trigger your ability here (e.g., fireball, flame, etc.)
		
func update_mana_sprite():
	var mana_ratio := float(current_mana) / float(max_mana)  # 0.0 → 1.0
	var max_frame := 6  # 0 = full, 6 = empty
	var frame_index := int(round((1.0 - mana_ratio) * max_frame))
	player.get_node("character").get_node("manameter").frame = frame_index

func _draw():
	var mouse_pos = get_global_mouse_position()
	var distance = player.get_node("character").global_position.distance_to(mouse_pos)

	if distance <= max_distance:
		is_in_range = true
		draw_line(player.get_node("character").global_position, to_local(mouse_pos), line_color, 2.0)
	else:
		is_in_range = false
