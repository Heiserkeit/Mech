extends Node2D


var current_point_path: PackedVector2Array
var current_map_point_path: PackedVector2Array
@onready var tile_map = $"../TileMap"


func  _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if current_point_path.is_empty():
		return
		
	draw_polyline(current_point_path, Color.RED)
	
func set_path(path: PackedVector2Array):
	current_point_path.clear()
	current_map_point_path = path
	for point in current_map_point_path:
		current_point_path.append(tile_map.map_to_local(point))
