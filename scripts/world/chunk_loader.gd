extends Node2D

@export var tile_map: TileMapLayer  # The TileMap node to populate
@export var tile_set: TileSet  # The TileSet resource to use
@export var tile_size: Vector2 = Vector2(64, 64)  # Size of each tile
@export var chunk_size: Vector2 = Vector2(16, 16)  # Size of each chunk in tiles
@export var bounds: Rect2 = Rect2(Vector2.ZERO, Vector2(1024, 1024))  # Bounds to fill

func _ready() -> void:
	# Ensure TileMap and TileSet are valid
	if tile_map and tile_set:
		load_tiles_into_world()
	else:
		printerr("TileMap or TileSet is not assigned!")

func load_tiles_into_world() -> void:
	# Calculate how many chunks are needed to fill the bounds
	var chunks_x = ceil(bounds.size.x / (chunk_size.x * tile_size.x))
	var chunks_y = ceil(bounds.size.y / (chunk_size.y * tile_size.y))

	for chunk_x in range(chunks_x):
		for chunk_y in range(chunks_y):
			var chunk_position = Vector2(chunk_x, chunk_y) * chunk_size * tile_size
			_load_chunk(chunk_position)

func _load_chunk(chunk_position: Vector2) -> void:
	# Add a new TileMap for this chunk
	var chunk_tile_map = TileMapLayer.new()
	chunk_tile_map.tile_set = tile_set
	chunk_tile_map.cell_size = tile_size
	add_child(chunk_tile_map)

	# Calculate the chunk bounds
	var chunk_bounds = Rect2(chunk_position, chunk_size * tile_size)

	# Populate the chunk with tiles
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			var tile_position = chunk_position + Vector2(x, y) * tile_size
			if bounds.has_point(tile_position):
				chunk_tile_map.set_cellv(Vector2(x, y), 0)  # Set tile ID 0 for example

func bounds_has_point(point: Vector2) -> bool:
	return bounds.has_point(point)
