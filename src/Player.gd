extends Sprite2D

@onready var tile_map = $"../TileMap"
@onready var parent : Node = $".."
@onready var Path : Node = $"../Path"
var map_position: Vector2i

var selectic: Node 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_position = Vector2i(5,5)
	global_position = tile_map.map_to_local(map_position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		map_position = tile_map.local_to_map(get_global_mouse_position())
		global_position = tile_map.map_to_local(map_position)
		print(map_position, " : ",global_position )
		
	elif event.is_action_pressed("mouse_right"):
		if parent.get_mech(map_position) != null:
			#print(parent.name)
			selectic = parent.get_mech(map_position)
			print(selectic.name)
		elif selectic != null:
			selectic.move(map_position)
			
	elif event.is_action_pressed("ui_up"):
		map_position.y -= 1
		global_position = tile_map.map_to_local(map_position)
	elif event.is_action_pressed("ui_down"):
		map_position.y += 1
		global_position = tile_map.map_to_local(map_position)
	elif event.is_action_pressed("ui_left"):
		map_position.x -= 1
		global_position = tile_map.map_to_local(map_position)
	elif event.is_action_pressed("ui_right"):
		map_position.x += 1
		global_position = tile_map.map_to_local(map_position)
	elif event.is_action_pressed("Aktion a"):
		if selectic != null:
			Path.set_path(parent.crate_path(selectic.get_map_position() , map_position))
			if selectic is Mech:
				selectic.move_path(parent.crate_path(selectic.get_map_position() , map_position))
			
