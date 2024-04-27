extends AStar2D

class_name Mech_Star

var Astar: AStar2D
var tile_map:TileMap
var tile_laver: int
var star_cells : Array[Cell] = []

func set_up(tile_map_IM:TileMap, tile_laver_IM: int):
	star_cells = []
	tile_map = tile_map_IM
	tile_laver = tile_laver_IM


func crate_A_star():
	Astar = AStar2D.new()
	var i:int = 0
	var tile_date: TileData
	var cell_position: Vector2i 
	var nachber_cellen: Array[Vector2i]
	
	#Halle zellen aus der tielmap in A*
	for cell in tile_map.get_used_cells(0):
		tile_date =  tile_map.get_cell_tile_data(tile_laver, cell)#
		
		if tile_date.get_custom_data("walkable") == true:
			#get_custom_data("game_area") weight_scale
			Astar.add_point(i,cell,tile_date.get_custom_data("weight_scale"))
			i = i + 1
			star_cells.append(Cell.new(Vector2i(cell),tile_date.get_custom_data("weight_scale"))) 
		
		
	for cell_id in Astar.get_point_count():
		cell_position = Astar.get_point_position(cell_id)
		nachber_cellen = tile_map.get_surrounding_cells(cell_position)
		for cell in nachber_cellen:
			if tile_map.get_cell_tile_data(tile_laver, cell).get_custom_data("walkable") == true :
				Astar.connect_points(cell_id, Astar.get_closest_point(cell))
	
	print("Astar.get_point_count() : ",Astar.get_point_count())
	print(Astar.get_point_connections(Astar.get_closest_point(Vector2i(4,3))))
	print(tile_map.get_surrounding_cells(Vector2i(4,3)))
	
	
func crate_path(map_position_start:Vector2i, map_position_end:Vector2i) -> PackedVector2Array:
	var path = Astar.get_point_path(Astar.get_closest_point(map_position_start),Astar.get_closest_point(map_position_end))
	print(path)
	return path
	
func crate_weight_path(map_position_start:Vector2i, map_position_end:Vector2i)-> WeightedPath:
	var w_path : WeightedPath = WeightedPath.new(crate_path(map_position_start, map_position_end),0)
	var weigth : float = 0
	var path = w_path.path.duplicate()
	for cell in star_cells:
		for path_cell in path:
			# wenn cell in path dann soll das gewicht der cell zum gewcht es path hin zugefügt werden
			if Vector2i(path_cell) == cell.postion:
				weigth += cell.weight
				path.remove_at(path.find(path_cell))
				break
				
		if path.is_empty():
			break
	
	w_path.weight = weigth
	return w_path
	




