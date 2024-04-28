extends CharacterBody2D
class_name Mech

#var tile_map:PackedScene
var tile_map:TileMap
@onready var sprite_2d = $Sprite2D

var is_moving = false
var rng = RandomNumberGenerator.new()
var map_position:Vector2i = Vector2i()
var move_map_position: Vector2
var current_id_path: Array[Vector2i]
var current_point_path: PackedVector2Array
var cell_rotation = {"UR":30, "U": 90, "UL": 150, "OL": 210, "O": 270, "OR": 330} 

func _input(event: InputEvent) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if is_moving == false:
		return
	
	if global_position == move_map_position:
		if current_id_path.is_empty():
			is_moving = false
			return
		else:
			#print("move_map_position: ",move_map_position)
			#print("current_id_path: ",current_id_path)
			move_map_position = tile_map.map_to_local(current_id_path.pop_front())
			#print("move_map_position: ",move_map_position)
			#print("current_id_path: ",current_id_path)
	
	#sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)
	global_position = global_position.move_toward(move_map_position, 1)

func move(new_map_position):
	if is_moving:
		return
	is_moving = true

	move_map_position = tile_map.map_to_local(new_map_position)
	#global_position = tile_map.map_to_local(new_map_position)
	#print(sprite_2d.global_position)

func move_path(point_path:PackedVector2Array):
	if is_moving:
		return
	is_moving = true
	print(point_path)
	
	current_point_path = point_path
	current_point_path.slice(1)
	current_id_path = []
	
	for i in point_path.size():
		current_id_path.append(Vector2i(point_path[i]))
		current_point_path[i] = tile_map.map_to_local(current_point_path[i])
	
	map_position = current_id_path.back()
	move_map_position = tile_map.map_to_local(current_id_path.front())

func _ready() -> void:
	#map_position = Vector2i(rng.randi_range ( 1, 4),rng.randi_range ( 1, 4))
	global_position = tile_map.map_to_local(map_position)
	print(map_position)
	
	
func get_map_position() -> Vector2i:
	return map_position
	
func at_map_position(in_map_position:Vector2i) -> bool:
	if in_map_position == map_position:
		return true
	else:
		return false
	
	
