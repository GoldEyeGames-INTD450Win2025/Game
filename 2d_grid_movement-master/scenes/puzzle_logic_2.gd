extends Container

var pieces = []
var sprites = []
var hidden_pieces = []
var init_grid
var solved_grid
var left_grid
var right_grid
var piece_size = Vector2(128, 128)
var solved = false
var to_find = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var puzzle_pieces = $Puzzle_Pieces
	right_grid = $Right_Grid
	right_grid._create(4, 5, 5)
	left_grid = $Left_Grid
	left_grid._create(3, 2, 5)
	
	for i in 11:
		var area = Area2D.new()
		var collision = CollisionShape2D.new()
		var rect = RectangleShape2D.new()
		
		pieces.append(PuzzlePiece.new())
		
		rect.extents = piece_size * 0.5
		collision.set_shape(rect)
		#collision.position = piece_size
		area.add_child(collision)
		pieces[i].add_child(area)
	
	for i in 4:
		sprites.append([])
		for j in 5:
			sprites[i].append(Sprite2D.new())
			sprites[i][j].texture = load(str("res://assets/art_drawn_tile/mural_2/row-", i+1, "-column-", j+1, ".png"))
			sprites[i][j].centered = true
			sprites[i][j].visible = true
	
	# piece 1 
	pieces[0].dims = Vector2(2, 2)
	pieces[0].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y * 2) * 0.5
	pieces[0].get_child(0).get_child(0).position = Vector2(piece_size.x, piece_size.y) * 0.5
	sprites[0][1].position = Vector2(piece_size.x, 0)
	sprites[1][0].position = Vector2(0, piece_size.y)
	sprites[1][1].position = Vector2(piece_size.x, piece_size.y)
	pieces[0].add_child(sprites[0][0])
	pieces[0].add_child(sprites[0][1])
	pieces[0].add_child(sprites[1][0])
	pieces[0].add_child(sprites[1][1])
	
	# piece 2
	pieces[1].dims = Vector2(1, 2)
	pieces[1].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[1].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[0][3].position = Vector2(piece_size.x, 0)
	pieces[1].add_child(sprites[0][2])
	pieces[1].add_child(sprites[0][3])
	
	# piece 3
	pieces[2].dims = Vector2(2, 1)
	pieces[2].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x, piece_size.y * 2) * 0.5
	pieces[2].get_child(0).get_child(0).position = Vector2(0, piece_size.y) * 0.5
	sprites[1][4].position = Vector2(0, piece_size.y)
	pieces[2].add_child(sprites[0][4])
	pieces[2].add_child(sprites[1][4])
	
	# piece 4
	pieces[3].dims = Vector2(2, 1)
	pieces[3].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x, piece_size.y * 2) * 0.5
	pieces[3].get_child(0).get_child(0).position = Vector2(0, piece_size.y) * 0.5
	sprites[2][2].position = Vector2(0, piece_size.y)
	pieces[3].add_child(sprites[1][2])
	pieces[3].add_child(sprites[2][2])
	
	# piece 5
	pieces[4].add_child(sprites[1][3])
	
	# piece 6
	pieces[5].dims = Vector2(1, 2)
	pieces[5].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[5].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[2][1].position = Vector2(piece_size.x, 0)
	pieces[5].add_child(sprites[2][0])
	pieces[5].add_child(sprites[2][1])
	
	# piece 7
	pieces[6].dims = Vector2(2, 2)
	pieces[6].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y * 2) * 0.5
	pieces[6].get_child(0).get_child(0).position = Vector2(piece_size.x, piece_size.y) * 0.5
	sprites[2][4].position = Vector2(piece_size.x, 0)
	sprites[3][3].position = Vector2(0, piece_size.y)
	sprites[3][4].position = Vector2(piece_size.x, piece_size.y)
	pieces[6].add_child(sprites[2][3])
	pieces[6].add_child(sprites[2][4])
	pieces[6].add_child(sprites[3][3])
	pieces[6].add_child(sprites[3][4])
	
	# piece 8
	pieces[7].dims = Vector2(1, 2)
	pieces[7].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[7].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[3][1].position = Vector2(piece_size.x, 0)
	pieces[7].add_child(sprites[3][0])
	pieces[7].add_child(sprites[3][1])
	
	# piece 9
	pieces[8].add_child(sprites[3][2])


	init_grid = [right_grid.slots[2][3], right_grid.slots[1][0], right_grid.slots[0][4],
				   right_grid.slots[1][2], left_grid.slots[1][0], left_grid.slots[2][0],
				   right_grid.slots[2][0], right_grid.slots[0][2], left_grid.slots[0][1],
					left_grid.slots[0][0], left_grid.slots[1][1]]
	
	solved_grid = [right_grid.slots[0][0], right_grid.slots[0][2], right_grid.slots[0][4],
				   right_grid.slots[1][2], right_grid.slots[1][3], right_grid.slots[2][0],
				   right_grid.slots[2][3], right_grid.slots[3][0], right_grid.slots[3][2]]
		
	for i in pieces.size():
		puzzle_pieces.add_child(pieces[i])
		pieces[i]._initialize(right_grid)
		pieces[i]._set_pos(init_grid[i], true)
		#_make_grid_occupied(pieces[i], init_grid[i], init_grid[i].get_parent())
	
	# placeholder pieces = 10 and 11
	hidden_pieces = [pieces[4], pieces[5], pieces[8], pieces[9], pieces[10]]
	for hidden_piece in hidden_pieces:
		hidden_piece.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for i in range(Global.pieces_found):
		hidden_pieces[i].visible = true
	solved = _puzzle_solved()
	if solved:
		Global.puzzle_solved = true

func _make_grid_occupied(piece, init_grid_square, grid):
	for x in range(piece.dims.x):
		for y in range(piece.dims.y):
			if x == 0 and y == 0:
				piece.anker_ref = grid.slots[x + init_grid_square.grid_pos.x][y + init_grid_square.grid_pos.y]
			piece.occupying.append(grid.slots[x + init_grid_square.grid_pos.x][y + init_grid_square.grid_pos.y])
			grid.slots[x + init_grid_square.grid_pos.x][y + init_grid_square.grid_pos.y].is_occupied = true

func _puzzle_solved() -> bool:
	for i in solved_grid.size():
		if Global.pieces_found > to_find or pieces[i].anker_ref != solved_grid[i] or Global.is_dragging:
			return false
	return true
