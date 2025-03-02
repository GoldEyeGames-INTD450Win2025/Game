class_name PuzzlePiece
extends Node2D

var draggable = false
var is_inside_dropabale = false
var currently_being_dragged = false
var has_released = true
var is_swiping = false
var exited = true
var swipe_start_pos: Vector2
var anker_ref
var to_anker
var occupying = []
var body_list = []
var offset: Vector2
var dims = Vector2(1, 1)
var right_grid

func _ready():
	self.z_index = 5

func _initialize(sliding_grid):
	var area = get_child(0)
	area.mouse_entered.connect(_on_area_2d_mouse_entered)
	area.mouse_exited.connect(_on_area_2d_mouse_exited)
	area.body_entered.connect(_on_area_2d_body_entered)
	area.body_exited.connect(_on_area_2d_body_exited)
	visibility_changed.connect(_on_visibility_change)
	right_grid = sliding_grid

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update(delta)

func _update(_delta: float):
	if exited == false and not Global.is_dragging and not Input.is_action_pressed("left_click") and not Input.is_action_pressed("right_click"):
		draggable = true
		
	if draggable:
		_update_anker()
		if not _update_left_click():
			_update_right_click()
			
	if Input.is_action_just_released("left_click"):
		Global.is_dragging = false

func _update_anker():
	if currently_being_dragged:
		for body in body_list:
			is_inside_dropabale = _process_grid(body)
			if is_inside_dropabale:
				break

func _update_left_click() -> bool:
	if Input.is_action_just_pressed("left_click"):
		Global.is_dragging = true
		offset = get_global_mouse_position() - global_position
		currently_being_dragged = true
		return true
			
	elif Input.is_action_pressed("left_click"):
		global_position = get_global_mouse_position() - offset
		z_index = 10
		return true
		
	elif Input.is_action_just_released("left_click"):
		_process_release()
		has_released = true
		return true
		
	return false

func _update_right_click() -> bool:
	if Input.is_action_pressed("right_click"):
		if not is_swiping:
			is_swiping = true
			swipe_start_pos = get_global_mouse_position()
		return true
			
	elif Input.is_action_just_released("right_click") and is_swiping:
		is_swiping = false
		draggable = not exited
		_process_swipe()
		return true
		
	return false

func _process_grid(body: Node2D) -> bool:
	if ((not body.is_occupied) or (body in occupying)):
		if (anker_ref.get_parent() != right_grid or anker_ref.get_parent() != body.get_parent()):
			if _within_range(body):
				var neighbours = _valid_grid(body)
				if neighbours:
					to_anker = body
					return true
	return false
	
func _within_range(body: Node2D) -> bool:
	return (abs(body.global_position.x - global_position.x) < (128 * 0.4)) and (abs(body.global_position.y - global_position.y) < (128 * 0.4))

func _process_release():
	currently_being_dragged = false
	
	if is_inside_dropabale:
		anker_ref = to_anker
		
	_set_pos(anker_ref)

func _set_pos(grid_tile, init=false) -> void:
	var spacing = grid_tile.get_parent().spacing
	var grid_scale = grid_tile.get_parent().scale
	var neighbours = []
	
	if not init:
		var new_pos = grid_tile.global_position + (Vector2(dims.y - 1, dims.x - 1) * (grid_scale * spacing)/2)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", new_pos, 0.05).set_ease(Tween.EASE_OUT)
		await tween.finished
		self.z_index = 5
		
	else:
		#grid_tile.get_parent()
		#var piece_offset = grid_tile.get_parent().global_position - get_parent().global_position
		global_position = grid_tile.global_position  + (Vector2(dims.y - 1, dims.x - 1) * (grid_scale * spacing)/2)
		
	anker_ref = grid_tile
	
	neighbours = _valid_grid(grid_tile)
	for i in occupying.size():
		occupying[i].is_occupied = false
	occupying.clear()
	
	if neighbours:
		for neighbour in neighbours:
			neighbour.is_occupied = true
			occupying.append(neighbour)

func _process_swipe():
	var curr_pos = get_global_mouse_position()
	var swipe_vector = curr_pos - swipe_start_pos
	var swipe_dir
	var magnitude = floor(max(abs(swipe_vector.x), abs(swipe_vector.y)) / 85)
	magnitude = max(magnitude, 1)
	
	if abs(swipe_vector.x) > 10 or abs(swipe_vector.y) > 10:
		if abs(swipe_vector.x) > abs(swipe_vector.y):
			swipe_dir = Vector2(swipe_vector.x / abs(swipe_vector.x), 0)
		else:
			swipe_dir = Vector2(0, swipe_vector.y / abs(swipe_vector.y))
			
		var grid = anker_ref.get_parent()
		for i in range(magnitude):
			var target = Vector2(anker_ref.grid_pos.x + (swipe_dir.y), anker_ref.grid_pos.y + (swipe_dir.x))
			if _within_grid_boundaries(target.x, target.y, grid):
				is_inside_dropabale = _process_grid_swipe(grid.slots[target.x][target.y])
				_process_release()

func _within_grid_boundaries(x, y, grid):
	var size_x = grid.slots.size()
	var size_y = grid.slots[0].size()
	return 0 <= x and x < size_x and 0 <= y and y < size_y

func _process_grid_swipe(body: Node2D) -> bool:
	if (not body.is_occupied) or body in occupying:
		var neighbours = _valid_grid(body)
		if neighbours:
			to_anker = body
			return true
	return false

func _valid_grid(body):
	var grid = body.get_parent()
	var neighbours = []
	if (grid.slots.size() > (body.grid_pos.x + dims.x - 1)) and (grid.slots[0].size() > (body.grid_pos.y + dims.y - 1)):
		for i in range(dims.x):
			for j in range(dims.y):
				if (not grid.slots[i + body.grid_pos.x][j + body.grid_pos.y].is_occupied) or grid.slots[i + body.grid_pos.x][j + body.grid_pos.y] in occupying:
					neighbours.append(grid.slots[i + body.grid_pos.x][j + body.grid_pos.y])
				else:
					return false
		return neighbours
	return false

func _on_area_2d_mouse_entered() -> void:
	exited = false

func _on_area_2d_mouse_exited() -> void:
	exited = true
	if not is_swiping:
		draggable = false
	if currently_being_dragged:
		_process_release()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Dropable"):
		body_list.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Dropable"):
		for i in body_list.size():
			if body == body_list[i]:
				body_list.remove_at(i)
				#body.modulate = Color(Color.DIM_GRAY, 1)
				if body == to_anker:
					is_inside_dropabale = false
				break

func _on_visibility_change() -> void:
	for neighbour in occupying:
		neighbour.visible = visible
