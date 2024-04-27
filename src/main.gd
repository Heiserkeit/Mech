extends Node2D

@export var mech_Szn = preload("res://src/mech.tscn")
@onready var tile_map = $TileMap
@onready var player = $Player
var tile_map_inst
var mech_list:Array[Mech] = []
var tile_laver = 0
var mech_star:Mech_Star
	

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
	
	mech_star = Mech_Star.new()
	mech_star.set_up(tile_map, tile_laver)
	mech_star.crate_A_star()
	
	player.set_up(mech_star)
	
	


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
	
	
func crate_path(map_position_start:Vector2i, map_position_end:Vector2i) -> PackedVector2Array:
	return mech_star.crate_path(map_position_start, map_position_end)
