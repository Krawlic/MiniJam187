extends Camera2D

var player: Node2D
var level: Node2D
var tilemap: TileMap

func _ready():
	level = get_parent().get_parent().get_parent()
	if level and level.name != "End":
		tilemap = level.get_node("map")
		player = level.get_node("Player").get_node("character")
		if level.large:
			SignalBus.main_camera_off.emit()
			self.enabled = true
	pass
	
func _process(_delta):
	if not player or not tilemap or not level.large:
		return

	# Camera offset (sit 64px above player)
	var target_pos = player.global_position + Vector2(0, -32)
	var cam_half_size = get_viewport_rect().size * 0.5 * zoom

	# Get map boundaries in pixels
	var used_rect = tilemap.get_used_rect()

	var map_min = tilemap.to_global(tilemap.map_to_local(used_rect.position))  # top-left in world coords
	var map_max = tilemap.to_global(tilemap.map_to_local(used_rect.position + used_rect.size))  # bottom-right in world coords

	# Account for clamping edges fully
	var min_pos = map_min + cam_half_size
	var max_pos = map_max - cam_half_size
	
	max_pos.x = max_pos.x - 8

	# Clamp the camera to stay inside the map
	global_position = target_pos.clamp(min_pos, max_pos)
