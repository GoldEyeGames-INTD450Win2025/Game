extends CenterContainer

var pieces = []
var sprites = []
var init_positions
var grid
var piece_size = Vector2(128, 128)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var puzzle_pieces = $Puzzle_Pieces
	for i in 9:
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
			sprites[i][j].texture = load(str("res://assets/art_drawn_tile/mural_1/row-", i+1, "-column-", j+1, ".png"))
			sprites[i][j].centered = true
			sprites[i][j].visible = true
	
	# piece 1 
	pieces[0].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[0].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[0][1].position = Vector2(piece_size.x, 0)
	pieces[0].add_child(sprites[0][0])
	pieces[0].add_child(sprites[0][1])
	
	# piece 2
	pieces[1].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[1].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[0][3].position = Vector2(piece_size.x, 0)
	pieces[1].add_child(sprites[0][2])
	pieces[1].add_child(sprites[0][3])
	
	# piece 3
	pieces[2].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x, piece_size.y * 2) * 0.5
	pieces[2].get_child(0).get_child(0).position = Vector2(0, piece_size.y) * 0.5
	sprites[1][4].position = Vector2(0, piece_size.y)
	pieces[2].add_child(sprites[0][4])
	pieces[2].add_child(sprites[1][4])
	
	# piece 4
	pieces[3].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y * 2) * 0.5
	pieces[3].get_child(0).get_child(0).position = Vector2(piece_size.x, piece_size.y) * 0.5
	sprites[1][1].position = Vector2(piece_size.x, 0)
	sprites[2][0].position = Vector2(0, piece_size.y)
	sprites[2][1].position = Vector2(piece_size.x, piece_size.y)
	pieces[3].add_child(sprites[1][0])
	pieces[3].add_child(sprites[1][1])
	pieces[3].add_child(sprites[2][0])
	pieces[3].add_child(sprites[2][1])
	
	# piece 5
	pieces[4].add_child(sprites[1][2])
	
	# piece 6
	pieces[5].add_child(sprites[1][3])
	
	# piece 7
	pieces[6].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y) * 0.5
	pieces[6].get_child(0).get_child(0).position = Vector2(piece_size.x, 0) * 0.5
	sprites[3][1].position = Vector2(piece_size.x, 0)
	pieces[6].add_child(sprites[3][0])
	pieces[6].add_child(sprites[3][1])
	
	# piece 8
	pieces[7].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x * 2, piece_size.y * 2) * 0.5
	pieces[7].get_child(0).get_child(0).position = Vector2(piece_size.x, piece_size.y) * 0.5
	sprites[2][3].position = Vector2(piece_size.x, 0)
	sprites[3][2].position = Vector2(0, piece_size.y)
	sprites[3][3].position = Vector2(piece_size.x, piece_size.y)
	pieces[7].add_child(sprites[2][2])
	pieces[7].add_child(sprites[2][3])
	pieces[7].add_child(sprites[3][2])
	pieces[7].add_child(sprites[3][3])
	
	# piece 9
	pieces[8].get_child(0).get_child(0).shape.extents = Vector2(piece_size.x, piece_size.y * 2) * 0.5
	pieces[8].get_child(0).get_child(0).position = Vector2(0, piece_size.y) * 0.5
	sprites[3][4].position = Vector2(0, piece_size.y)
	pieces[8].add_child(sprites[2][4])
	pieces[8].add_child(sprites[3][4])


	grid = $Grid
	# 0, 2, 4, 5, 7, 8, 15, 12, 14
	init_positions = [grid.slots[0][0].position, grid.slots[0][2].position, grid.slots[0][4].position,
					  grid.slots[1][0].position, grid.slots[1][2].position, grid.slots[1][3].position,
					  grid.slots[3][0].position, grid.slots[2][2].position, grid.slots[2][4].position]

	for i in pieces.size():
		print(i, init_positions[i])
		pieces[i].position = init_positions[i] 
		pieces[i].initialPos = pieces[i].global_position
		pieces[i]._connect()
		puzzle_pieces.add_child(pieces[i])
		#if i != 3:
	#		pieces[i].visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
