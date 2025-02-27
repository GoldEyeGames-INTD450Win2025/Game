extends Sprite2D
var rows = 4
var cols = 5
var spacing = 5
var slots = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _create(num_rows: int, num_cols: int, num_spacing: int) -> void:
	rows = num_rows
	cols = num_cols
	spacing = num_spacing
	
	for row in range(rows):
		slots.append([])
		slots[row] = []
		for column in range(cols):
			slots[row].append([])
			slots[row][column] = GridSquare.new()
			slots[row][column].grid_pos = Vector2(row, column)
			add_child(slots[row][column])
			slots[row][column].global_position += Vector2((0.8 * (128 + spacing) * column + 64), (0.8 * (128 + spacing) * row) + 64)
			slots[row][column].name = ("Slot[" + str(row) + "][" + str(column) + "]")
