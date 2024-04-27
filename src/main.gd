extends Node2D

@export var mech_Szn = preload("res://src/mech.tscn")
@onready var tile_map = $TileMap
var tile_map_inst
var mech_list:Array[Mech] = []
var Astar: AStar2D
var tile_laver = 0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#tile_map_inst = tile_map.instantiate()
	#add_child(tile_map_inst)
	#var mech_load = load(mech_Szn) 
	for y in 5:
		var map_posison: = Vector2i(4, y+3)
		var mech_Object = factory_mech.new_mech(tile_map, map_posison)
		mech_Object.name = mech_Object.name + "0" + str(y)
		add_child(mech_Object)
		mech_list.append(mech_Object)

	for y in 5:
		var map_posison: = Vector2i(25,y+3)
		var mech_Object = factory_mech.new_mech(tile_map, map_posison)
		mech_Object.name = mech_Object.name + "1" + str(y)
		add_child(mech_Object)
		#mech_list.add(mech_Object)
	
	crate_A_star()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_childs():
	for _i in self.get_children ():
		print(_i)

func get_mech(in_map_position) -> Mech:
	for _i in mech_list:
		if _i.at_map_position(in_map_position):
			return _i
	return null
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right"):
		#get_childs()
		#get_mech()
		pass
		
		
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
			Astar.add_point(i,cell)
			i = i + 1
		
		
	for cell_id in Astar.get_point_count():
		cell_position = Astar.get_point_position(cell_id)
		nachber_cellen = tile_map.get_surrounding_cells(cell_position)
		for cell in nachber_cellen:
			if tile_map.get_cell_tile_data(tile_laver, cell).get_custom_data("walkable") == true :
				Astar.connect_points(cell_id, Astar.get_closest_point(cell))
	
	print(Astar.get_point_count())
	print(Astar.get_point_connections(Astar.get_closest_point(Vector2i(4,3))))
	print(tile_map.get_surrounding_cells(Vector2i(4,3)))
	
	
func crate_path(map_position_start:Vector2i, map_position_end:Vector2i) -> PackedVector2Array:
	var path = Astar.get_point_path(Astar.get_closest_point(map_position_start),Astar.get_closest_point(map_position_end))
	print("2")
	print(path)
	return path
	
