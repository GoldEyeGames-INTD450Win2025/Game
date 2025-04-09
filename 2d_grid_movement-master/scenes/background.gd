extends TileMapLayer

@onready var thislayer : TileMapLayer = $"."

#@onready var obstacles : TileMapLayer = $"../Obstacles/Small Obstacles"
@onready var obstacles : TileMapLayer = $"../Obstacles/Large Abstacles"

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in obstacles.get_used_cells_by_id(2):
		return true
	return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if coords in obstacles.get_used_cells_by_id(2):
		tile_data.set_navigation_polygon(0, null)
		thislayer.set_navigation_polygon(0, null)
