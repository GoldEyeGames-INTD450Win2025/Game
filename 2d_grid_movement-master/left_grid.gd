extends Sprite2D
var rows = 3
var cols = 2
var spacing = 5
var slots = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for row in range(rows):
		slots.append([])
		slots[row] = []
		for column in range(cols):
			slots[row].append([])
			slots[row][column] = GridSquare.new()
			add_child(slots[row][column])
			slots[row][column].global_position += Vector2((0.8 * (128 + spacing) * column + 64), (0.8 * (128 + spacing) * row) + 64)
			print(row, " ", column, ": ", Vector2((0.8 * (128 + spacing) * column + 64), (0.8 * (128 + spacing) * row) + 64))
			slots[row][column].name = ("Slot[" + str(row) + "][" + str(column) + "]")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
