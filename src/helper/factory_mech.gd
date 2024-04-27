extends Node

class_name factory_mech

const my_scene: PackedScene = preload("res://src/mech.tscn")


static func new_mech(tile_map_im:TileMap, map_posison_im:Vector2i) -> Mech:
	var new_Mech: Mech = my_scene.instantiate()
	new_Mech.map_position = map_posison_im
	new_Mech.tile_map = tile_map_im
	return new_Mech
	
